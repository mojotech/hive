class RepositoriesController < ApplicationController
  def show
    render locals: { repository: current_user.repository(params[:owner], params[:repo_name]) }
  rescue Octokit::NotFound
    render locals: { repository: nil }
  end

  def create_branch
    current_user.create_branch(params[:owner], params[:repo_name], params[:branch_name])
    redirect_to action: 'show'
  end
end
