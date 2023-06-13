# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @should_render_navbar = true

    @rooms = current_user.entries.map(&:room)
  end

  def create
    room = Room.create
    current_entry = Entry.create(user_id: current_user.id, room_id: room.id)
    another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: room.id)

    redirect_to room_path(room), notice: 'チャットルームを作成しました'
  end

  def show
    @should_render_navbar = true

    user = Room.find_by(id: params[:id]).entries.find_by(user_id: current_user.id)
    redirect_to dashboard_path if user.nil? # MEMO ログインユーザーがエントリーしてないルームには入れない

    @room = Room.find(params[:id])
    @messages = @room.messages.all.order(created_at: :desc)

    @another_entry = Entry.find_another_entry_user(@room, current_user.id) # MEMO ログインユーザー以外の別のエントリーユーザー取得

    @message = Message.new
  end
end
