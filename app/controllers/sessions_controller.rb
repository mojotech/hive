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
    User.find_by(github_user_id: auth.user_id)
  end

  def create_user
    User.create(
      github_user_id: auth.user_id,
      nickname:       auth.nickname,
      email:          auth.email,
      auth_token:     auth.token
    )
  end

  def auth
    @auth ||= GithubAuth.new(request.env['omniauth.auth'])
  end
end
