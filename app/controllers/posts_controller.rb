# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to new_post_path
    else
      render :new
    end
  end

  def new
    @should_render_navbar = true

    @post = Post.new
  end

  def show
    @should_render_navbar = true

    @post = Post.find_by(id: params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to admins_index_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
