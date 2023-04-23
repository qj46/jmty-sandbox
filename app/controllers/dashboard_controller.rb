# frozen_string_literal: true

class DashboardController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    @should_render_navbar = true

    @posts = Post.all
  end

  def appearance
    @should_render_navbar = true
  end

  def show
    @should_render_navbar = true

    redirect_to dashboard_path if @user.nil?

    # @links = @user.links.where.not(url: '', title: '')



    @current_entry = current_user.entries
    @another_entry = @user.entries
    
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
    
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
