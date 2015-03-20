class User < ActiveRecord::Base
  validates :github_user_id, presence: true
  validates :nickname, presence: true
  validates :email, presence: true
  validates :auth_token, presence: true
end
