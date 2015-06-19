class OrganizationsController < ApplicationController
  def show
    add_breadcrumb params[:login]

    organization = Organization.new(login: params[:login], auth_token: current_user.auth_token)

    render locals: { repositories: organization.repositories.sort_by { |repo| repo[:name].downcase } }
  end
end
