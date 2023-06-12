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
    result = User.find_common_room(current_user.entries, @user.entries) #MEMO クラスメソッド
    is_room = result[:is_room]
    room_id = result[:room_id]

    return if @is_room # MEMO 既にroomがある場合、処理を終了
    @room = Room.new # MEMO dashboard/show.html.erb の <%= form_for @room do |f| %>でインスタンス変数使用
    @entry = Entry.new # MEMO dashboard/show.html.erb の <%= fields_for @entry do |e| %>でインスタンス変数使用
                       # MEMO RoomsController の another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: room.id)に渡す
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
    # @user = User.find_by_id(params[:id])
    # @posts = Post.where(params[:id]) # MEMO 脆弱性
  rescue StandardError
    @user = nil
  end
end
