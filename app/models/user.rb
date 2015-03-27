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

  def repository(owner, name)
    github_client.repository("#{owner}/#{name}")
  end

  def create_branch(owner, repo, name)
    repository = repository(owner, repo)
    default_branch_name = repository.default_branch
    root_sha = github_client.ref(repository.full_name, "heads/#{default_branch_name}").object.sha
    github_client.create_ref(repository.full_name, "heads/#{name}", root_sha)
  end

  def branches(repository_full_name)
    github_client.branches(repository_full_name)
  end

  private

  def github_client
    @github_client ||= Octokit::Client.new(access_token: auth_token, auto_paginate: true)
  end
end
