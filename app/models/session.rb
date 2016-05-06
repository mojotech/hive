class Session
  def initialize(request)
    @request = request
  end

  def create
    session[:user_id] = user.id
  end

  def destroy
    session[:user_id] = nil
  end

  private

  attr_reader :request

  delegate :session, to: :request

  def user
    @user ||= (find_user || create_user)
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
