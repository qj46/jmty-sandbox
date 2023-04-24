# frozen_string_literal: true

class ListsController < ApplicationController
  def index
    @lists = current_user.likes
  end
end
