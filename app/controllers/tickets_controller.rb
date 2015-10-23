class TicketsController < ApplicationController
  before_action :ensure_user

  def show
    render locals: { current_ticket: current_ticket }
  end

  def create
    return unless current_user.requested_tickets.create(ticket_params)
    redirect_to :back
  end

  def destroy
    if current_ticket.destroy
      redirect_to :back, flash: { success: 'Ticket deleted.' }
    else
      redirect_to :back, flash: { error: 'Ticket could not be deleted.' }
    end
  end

  def claim
    if current_ticket.update_attribute(:owner, current_user)
      redirect_to :back, flash: { success: 'Ticket claimed.' }
    else
      redirect_to :back, flash: { error: 'Ticket could not be claimed.' }
    end
  end

  def remove_owner
    if current_ticket.update_attribute(:owner, nil)
      redirect_to :back, flash: { success: 'Ticket owner removed.' }
    else
      redirect_to :back, flash: { error: 'Ticket owner could not be removed.' }
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description, :lane_id)
  end

  def current_ticket
    @current_ticket ||= current_app.tickets.find(params[:id])
  end

  def current_app
    @current_app ||= current_user.apps.find(params[:app_id])
  end
end
