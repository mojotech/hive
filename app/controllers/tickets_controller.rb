class TicketsController < ApplicationController
  before_action :ensure_user

  def show
    repository = Repository.new(
      name: current_app.repository_name,
      owner_login: current_app.repository_owner,
      auth_token: current_user.auth_token
    )
    ticket_branch = repository.branches.detect do |branch|
      branch.name.include?("/#{current_ticket.id}/")
    end
    patches = patches(repository, ticket_branch)
    render locals: { current_ticket: current_ticket, diff: patches }
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

  def patches(repository, branch)
    return [] unless branch.present?
    diff = repository.get_diff(branch[:name])
    diff.files.map do |file|
      diffy = Diffy::Diff.new('', '', include_plus_and_minus_in_html: true, include_diff_info: true)
      diffy.instance_variable_set(:@diff, file.patch)
      { filename: file.filename, patch: diffy }
    end
  end
end
