class Organization
  def initialize(login:, auth_token:)
    @login = login
    @auth_token = auth_token
  end

  def repositories
    github_client.organization_repositories(@login, type: :member).map do |repo_hash|
      Repository.new(
        name: repo_hash.name,
        owner_login: repo_hash.owner.login,
        auth_token: @auth_token
      )
    end
  end

  private

  def github_client
    @github_client ||= Octokit::Client.new(access_token: @auth_token, auto_paginate: true)
  end
end
