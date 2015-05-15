class UsersController < ApplicationController
  def show
    add_breadcrumb current_user.nickname

    render locals: { repositories: current_user.repositories }
  end
end