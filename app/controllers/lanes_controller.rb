class LanesController < ApplicationController
  before_action :ensure_user

  def create
    return unless current_app.lanes.create(allowed_params)
    redirect_to :back
  end

  private

  def allowed_params
    params.require(:lane).permit(:title)
  end

  def current_app
    current_user.apps.find(params[:app_id])
  end
end
