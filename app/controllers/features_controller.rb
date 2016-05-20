class FeaturesController < ApplicationController
  before_action :add_breadcrumbs, only: [:show]

  def create
    feature = current_app.features.create(feature_params)
    redirect_to app_feature_path(current_app, feature)
  end

  def show
    @feature = current_app.features.find(params[:id])
  end

  private def feature_params
    params.require(:feature).permit(:title)
  end

  private def current_app
    current_user.apps.find(params[:app_id])
  end

  private def add_breadcrumbs
    add_breadcrumb current_app.name, app_path(current_app)
  end
end
