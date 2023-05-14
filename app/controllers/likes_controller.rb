# frozen_string_literal: true

class LikesController < ApplicationController
  def show
    current_user.likes.create(post_id: params[:post_id])
    redirect_to dashboard_path, notice: 'いいねしました'
  end
end
