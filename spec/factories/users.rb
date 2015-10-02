# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, aliases: [:requester] do
    github_user_id 'github_id'
    nickname 'nickname'
    email 'user@email.com'
    auth_token 'oauth_token'
  end
end
