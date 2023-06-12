# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one_attached :avatar

  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy

  friendly_id :username, use: %i[slugged]

  validates :full_name, length: { maximum: 50 }
  validates :body, length: { maximum: 80 }
  validate :valid_username

  def valid_username
    # errors.add(:username, "is already taken") if User.exists?(username: username)
    restricted_username_list = %(admin root dashboard analytics appearance settings preferences calendar)
    errors.add(:username, 'is restricted') if restricted_username_list.include?(username)
  end

  def should_generate_new_friendly_id?
    username_changed? || slug.blank?
  end

  # MEMO 以下全てDM機能
  def self.find_common_room(current_user, another_user)
    current_entry = current_user.entries
    another_entry = another_user.entries
    is_room = false
    room_id = nil

    current_entry.each do |current|
      another_entry.each do |another|
        next unless current.room_id == another.room_id

        is_room = true # MEMO dashboard/show.html.erb の <% if @is_room %>でインスタンス変数使用
        room_id = current.room_id # MEMO dashboard/show.html.erb の <%= link_to 'DM', room_path(@room_id) %>でインスタンス変数使用
        break
      end
    end

    { is_room:, room_id: }
  end
end
