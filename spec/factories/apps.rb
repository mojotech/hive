# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :app do
    repository_name 'repo_name'
    repository_owner 'repo_owner'
  end
end
