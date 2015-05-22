class BranchesController < ApplicationController
  def show
    add_breadcrumb params[:owner]
    add_breadcrumb params[:repo_name]
    add_breadcrumb params[:branch_name]

    branch = current_user.branch(repo_fullname, params[:branch_name])

    file_content = current_user.get_feature_at_sha(repo_fullname, branch.commit.sha)
    render locals: { branch: branch, file_content: file_content }
  end

  def update
    current_user.edit_branch(repo_fullname, params[:branch_name], params[:description])
    redirect_to action: :show
  end

  private

  def repo_fullname
    "#{params[:owner]}/#{params[:repo_name]}"
  end
end
