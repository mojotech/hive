class User < ActiveRecord::Base
  validates :github_user_id, presence: true
  validates :nickname, presence: true
  validates :email, presence: true
  validates :auth_token, presence: true

  def organizations
    github_client.organizations
  end

  private

  def github_client
    @github_client ||= Octokit::Client.new(access_token: auth_token, auto_paginate: true)
  end
end
