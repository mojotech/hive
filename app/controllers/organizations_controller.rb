class OrganizationsController < ApplicationController
  def show
    render locals: { repositories: current_user.repositories_for_organization(params[:login]) }
  end
end
