# frozen_string_literal: true

class AdminController < ApplicationController
  def index
    @posts = Post.all
  end
end
