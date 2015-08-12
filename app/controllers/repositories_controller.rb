class RepositoriesController < ApplicationController
  def show
    add_breadcrumb params[:owner]
    add_breadcrumb params[:repo_name]

    repository = Repository.new(
      owner_login: params[:owner],
      name: params[:repo_name],
      auth_token: current_user.auth_token
    )
    branches = repository.branches
    render locals: { repository: repository, branches: branches }
  rescue Octokit::NotFound
    render locals: { repository: nil }
  end

  def create_branch
    repository = Repository.new(
      owner_login: params[:owner],
      name: params[:repo_name],
      auth_token: current_user.auth_token
    )
    repository.create_branch(params[:branch_name], params[:description])
    redirect_to action: 'show'
  end

  def new_branch
    add_breadcrumb params[:owner]
    add_breadcrumb params[:repo_name]

    repository = Repository.new(
      owner_login: params[:owner],
      name: params[:repo_name],
      auth_token: current_user.auth_token
    )
    render locals: { repository: repository }
  end
end
