class SessionsController < ApplicationController

  def create
    user_session.create
    flash[:notice] = 'Signed in!'

    redirect_to root_url
  end

  def destroy
    user_session.destroy
    flash[:notice] = 'Signed out!'

    redirect_to root_url
  end

  private

  def user_session
    @user_session ||= Session.new(request)
  end
end
