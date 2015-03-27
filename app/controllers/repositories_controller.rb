class RepositoriesController < ApplicationController
  def show
    render locals: { repository: current_user.repository(params[:owner], params[:repo_name]) }
  end
end
