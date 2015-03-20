class HomeController < ApplicationController
  def index
    if current_user
      repositories = current_user.repositories
      repository_names = repositories.map(&:full_name)
      render locals: { repository_names: repository_names }
    end
  end
end
