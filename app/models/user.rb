class User < ActiveRecord::Base
  validates :github_user_id, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :auth_token, presence: true

  def repositories
    user_repositories = github_client.repositories
    organization_repositories = github_client.organizations.reduce([]) do |repositories, organization|
      repositories + github_client.organization_repositories(organization.login, type: 'member')
    end
    user_repositories + organization_repositories
  end

  private

  def github_client
    @github_client ||= Octokit::Client.new(access_token: auth_token, auto_paginate: true)
  end
end
