class BranchesController < ApplicationController
  before_action :ensure_user

  def show
    add_breadcrumb params[:owner]
    add_breadcrumb params[:repo_name]
    add_breadcrumb params[:branch_name]

    repository = Repository.new(
      owner_login: params[:owner],
      name: params[:repo_name],
      auth_token: current_user.auth_token
    )

    branch = repository.branch(params[:branch_name])

    file_content = repository.get_feature_at_sha(branch.commit.sha)
    render locals: { branch: branch, file_content: file_content }
  end

  def update
    repository = Repository.new(
      owner_login: params[:owner],
      name: params[:repo_name],
      auth_token: current_user.auth_token
    )
    filename = repository.filename_for_new_branch(params[:branch_name])
    repository.edit_branch(params[:branch_name], filename, params[:description])
    redirect_to action: :show
  end
end
