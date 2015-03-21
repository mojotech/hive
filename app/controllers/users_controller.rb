class UsersController < ApplicationController
  def show
    render locals: { repositories: current_user.repositories }
  end
end
