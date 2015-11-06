class AcceptanceCriteriaController < ActionController::Base
  def create
    ticket = Ticket.find(params[:ticket_id])
    ticket.acceptance_criteria.create(acceptance_criteria_params)
    redirect_to :back
  end

  private def acceptance_criteria_params
    params.require(:acceptance_criterion).permit(:description)
  end
end
