class TicketsController < ApplicationController
  before_action :ensure_user

  def create
    if current_user.requested_tickets.create(ticket_params.merge(app: current_app))
      redirect_to :back
    end
  end

  private

  def ticket_params
    params.permit(:title, :description)
  end

  def current_app
    current_user.apps.find(params[:app_id])
  end
end
