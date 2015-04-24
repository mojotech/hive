class RepositoriesController < ApplicationController
  def show
    add_breadcrumb params[:owner]
    add_breadcrumb params[:repo_name]

    repository = current_user.repository(params[:owner], params[:repo_name])
    branches = current_user.branches(repository.full_name)
    render locals: { repository: repository, branches: branches }
  rescue Octokit::NotFound
    render locals: { repository: nil }
  end

  def create_branch
    current_user.create_branch(owner: params[:owner], repo: params[:repo_name], name: params[:branch_name], description: params[:description])
    redirect_to action: 'show'
  end

  def new_branch
    add_breadcrumb params[:owner]
    add_breadcrumb params[:repo_name]

    repository = current_user.repository(params[:owner], params[:repo_name])
    render locals: { repository: repository }
  end
end
