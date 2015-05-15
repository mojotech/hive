class BranchesController < ApplicationController
  def show
    add_breadcrumb params[:owner]
    add_breadcrumb params[:repo_name]
    add_breadcrumb params[:branch_name]

    branch = current_user.branch("#{params[:owner]}/#{params[:repo_name]}", params[:branch_name])
    render locals: { branch: branch }
  end
end
