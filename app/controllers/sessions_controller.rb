class SessionsController < ApplicationController

  def create
    session[:user_id] = user.id

    redirect_to root_url, notice: 'Signed in!'
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_url, notice: 'Signed out!'
  end

  private

  def user
    find_user || create_user
  end

  def find_user
    User.find_by(github_user_id: auth_data['uid'])
  end

  def create_user
    User.create(
      github_user_id: auth_data['uid'],
      nickname:       auth_data['info']['nickname'],
      email:          auth_data['info']['email'],
      auth_token:     auth_data['credentials']['token']
    )
  end

  def auth_data
    request.env['omniauth.auth']
  end
end
