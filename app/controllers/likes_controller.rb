# frozen_string_literal: true

class LikesController < ApplicationController
  def show
    current_user.likes.create(post_id: params[:post_id])
    redirect_to dashboard_path
  end

  def destroy
    current_user.likes.find_by(post_id: post.id).destroy
    redirect_to dashboard_path
  end
end
