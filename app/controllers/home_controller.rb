class HomeController < ApplicationController
  def index
    render locals: { organizations: current_user.organizations } if current_user
  end
end
