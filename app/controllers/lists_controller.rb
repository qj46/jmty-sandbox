# frozen_string_literal: true

class ListsController < ApplicationController
  def index
    @should_render_navbar = true

    @lists = current_user.likes
  end
end
