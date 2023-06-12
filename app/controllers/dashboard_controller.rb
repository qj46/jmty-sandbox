# frozen_string_literal: true

class DashboardController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    @should_render_navbar = true

    @posts = Post.all.order(created_at: :desc)
  end

  def appearance
    @should_render_navbar = true
  end

  def show
    @should_render_navbar = true
    redirect_to dashboard_path if @user.nil? # MEMO @userが存在しない場合、リダイレクト
    # @links = @user.links.where.not(url: '', title: '')

    # MEMO 以下全てDM機能
    return unless current_user # MEMO ログインしていない場合、処理を終了

    current_entry = current_user.entries
    another_entry = @user.entries
    return if @user.id == current_user.id

    current_entry.each do |current|
      another_entry.each do |another|
        if current.room_id == another.room_id
          @is_room = true # MEMO dashboard/show.html.erb の <% if @is_room %>でインスタンス変数使用
          @room_id = current.room_id # MEMO dashboard/show.html.erb の <%= link_to 'DM', room_path(@room_id) %>でインスタンス変数使用
        end
      end
    end

    return if @is_room # MEMO 既にroomがある場合、処理を終了
    @room = Room.new # MEMO dashboard/show.html.erb の <%= form_for @room do |f| %>でインスタンス変数使用
    @entry = Entry.new # MEMO dashboard/show.html.erb の <%= fields_for @entry do |e| %>でインスタンス変数使用
                       # MEMO RoomsController の another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: room.id)に渡す
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
    # @user = User.find_by_id(params[:id])
    # @posts = Post.where(params[:id])
  rescue StandardError
    @user = nil
  end
end
