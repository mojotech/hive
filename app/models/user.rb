class User < ActiveRecord::Base
  validates :github_user_id, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :auth_token, presence: true
end
