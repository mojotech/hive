class ProjectsController < ApplicationController
  before_action :ensure_user
  def index
    @projects = current_user.projects
  end

  def show
    @project = current_project
  end

  def new
    @project = current_user.projects.new
    @repositories = current_user.repositories
  end

  def create
    if current_user.projects.create(project_params)
      redirect_to action: :index
    end
  end

  def edit
    @project = current_project
    @repositories = current_user.repositories
  end

  def update
    @project = current_project
    if @project.update(project_params)
      redirect_to action: :index
    end
  end

  def destroy
    current_project.destroy

    redirect_to action: :index
  end

  private def project_params
    params.require(:project).permit(:name, :repository_name)
  end

  private def current_project
    current_user.projects.find(params[:id])
  end
end
