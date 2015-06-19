class Organization
  def initialize(login:, auth_token:)
    @login = login
    @auth_token = auth_token
  end

  def repositories
    github_client.organization_repositories(@login, type: :member)
  end

  private

  def github_client
    @github_client ||= Octokit::Client.new(access_token: @auth_token, auto_paginate: true)
  end
end
