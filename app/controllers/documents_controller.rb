class DocumentsController < ApplicationController
  before_action :add_breadcrumbs, only: [:show]

  def show
    sha = params[:id]
    app = current_app
    repository = Repository.new(
      name: app.repository_name,
      owner_login: app.repository_owner,
      auth_token: current_user.auth_token
    )
    @content = repository.get_content_at_sha(sha)
  end

  private

  def current_app
    @current_app ||= current_user.apps.find(params[:app_id])
  end

  private def add_breadcrumbs
    add_breadcrumb current_app.name, app_path(current_app)
  end
end
