class GithubAuth
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def user_id
    data.fetch('uid')
  end

  def nickname
    info.fetch('nickname')
  end

  def email
    info.fetch('email')
  end

  def token
    credentials.fetch('token')
  end


  private

  def info
    data.fetch('info')
  end

  def credentials
    data.fetch('credentials')
  end
end
