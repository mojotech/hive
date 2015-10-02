class TicketsController < ApplicationController
  before_action :ensure_user

  def create
    if current_user.requested_tickets.create(app: current_app, description: params[:description])
      redirect_to :back
    end
  end

  private

  def current_app
    current_user.apps.find(params[:app_id])
  end
end
