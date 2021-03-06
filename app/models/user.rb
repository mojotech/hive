class User < ActiveRecord::Base
  has_and_belongs_to_many :apps
  has_many :requested_tickets, foreign_key: 'requester_id', class_name: 'Ticket'
  has_many :owned_tickets, foreign_key: 'owner_id', class_name: 'Ticket'

  validates :github_user_id, presence: true
  validates :nickname, presence: true
  validates :email, presence: true
  validates :auth_token, presence: true

  def organizations
    github_client.organizations.map do |organization_hash|
      Organization.new(login: organization_hash.login, auth_token: auth_token)
    end
  end

  def repositories
    github_client.repositories.map do |repo_hash|
      Repository.new(
        name: repo_hash.name,
        owner_login: repo_hash.owner.login,
        auth_token: auth_token
      )
    end
  end

  private

  def github_client
    @github_client ||= Octokit::Client.new(access_token: auth_token, auto_paginate: true)
  end
end
