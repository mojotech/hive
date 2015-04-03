class RepositoriesController < ApplicationController
  def show
    render locals: { repository: current_user.repository(params[:owner], params[:repo_name]) }
  rescue Octokit::NotFound
    render locals: { repository: nil }
  end
end
