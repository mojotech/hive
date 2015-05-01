class OrganizationsController < ApplicationController
  def show
    add_breadcrumb params[:login]

    render locals: { repositories: current_user.repositories_for_organization(params[:login]).sort_by { |repo| repo[:name].downcase } }
  end
end
