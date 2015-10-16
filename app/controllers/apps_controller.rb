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
    return unless current_user.apps.create(app_params)
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
    params.require(:app).permit(:name, :repository_name)
  end

  private def current_app
    current_user.apps.find(params[:id])
  end
end
