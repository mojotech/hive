class HomeController < ApplicationController
  def index
    redirect_to '/apps' if current_user
  end
end
