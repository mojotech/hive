class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]

    user = User.find_by(github_user_id: auth["uid"]) || create_user(auth)

    session[:user_id] = user.id

    redirect_to root_url, notice: 'Signed in!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed out!'
  end

  private

  def create_user(auth)
    User.create(github_user_id: auth["uid"],
                name: auth["info"]["name"],
                email:  auth["info"]["email"],
                auth_token: auth["credentials"]["token"])
  end
end
