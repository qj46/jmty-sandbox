# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path, notice: '投稿しました'
    else
      redirect_to new_post_path, alert: '投稿に失敗しました'
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
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to request.referer, notice: '投稿を削除しました'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
