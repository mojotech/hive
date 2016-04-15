class AppsController < ApplicationController
  before_action :ensure_user
  before_action :add_breadcrumbs, only: [:show, :edit]

  def index
    @apps = current_user.apps
  end

  def show
    @app = current_app
  end

  def new
    @app = current_user.apps.new
    @repositories = current_user.repositories
  end

  def create
    app = current_user.apps.create(app_params)
    return unless app
    # Create github directory if needed
    repository = Repository.new(
      name: app.repository_name,
      owner_login: app.repository_owner,
      auth_token: current_user.auth_token
    )
    repository.create_branch('add_hive_documentation', "#{app.documentation_directory}/description", "#{params[:description]}\n")
    redirect_to action: :index
  end

  def edit
    @app = current_app
    @repositories = current_user.repositories
  end

  def update
    @app = current_app
    return unless @app.update(app_params)
    redirect_to action: :index
  end

  def destroy
    current_app.destroy

    redirect_to action: :index
  end

  private def add_breadcrumbs
    add_breadcrumb current_app.name, app_path(current_app)
  end

  private def app_params
    params.require(:app).permit(:name, :repository_full_name)
  end

  private def current_app
    current_user.apps.find(params[:id])
  end
end
