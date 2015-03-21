class User < ActiveRecord::Base
  validates :github_user_id, presence: true
  validates :nickname, presence: true
  validates :email, presence: true
  validates :auth_token, presence: true

  def organizations
    github_client.organizations
  end

  def repositories
    github_client.repositories
  end

  def repositories_for_organization(org_login)
    github_client.organization_repositories(org_login, type: :member)
  end

  private

  def github_client
    @github_client ||= Octokit::Client.new(access_token: auth_token, auto_paginate: true)
  end
end
