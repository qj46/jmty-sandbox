class DashboardController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_user, only: [:show]
  
  def index
    @should_render_navbar = true
    
    #@posts = Post.all
  end
  
  def appearance
    @should_render_navbar = true
  end
  
  def show
    @should_render_navbar = true
    
    redirect_to dashboard_path if @user.nil?
    
    #@links = @user.links.where.not(url: '', title: '')
  end
  
  private
  
  def set_user
    @user = User.friendly.find(params[:id])
    #@user = User.find_by_id(params[:id])
    #@posts = Post.where(params[:id])
  rescue
    @user = nil
  end
end
