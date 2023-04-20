# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # before_action :authenticate_user!
  before_action :set_should_render_navbar

  def set_should_render_navbar
    @should_render_navbar = false
  end
end
