class CommentsController < ApplicationController
  def create
    ticket = Ticket.find(params[:ticket_id])
    ticket.comments.create(comments_params)
    redirect_to :back
  end

  private def comments_params
    params.require(:comment).permit(:text)
  end
end
