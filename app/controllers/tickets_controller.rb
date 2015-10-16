class TicketsController < ApplicationController
  before_action :ensure_user

  def create
    return unless current_user.requested_tickets.create(ticket_params)
    redirect_to :back
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description, :lane_id)
  end

  def current_app
    current_user.apps.find(params[:app_id])
  end
end
