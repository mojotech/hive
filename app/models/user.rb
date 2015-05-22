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
    filename = filename_for_new_branch(name)
    new_commit = create_new_file_commit(repository.full_name, root_sha, filename)
    github_client.create_ref(repository.full_name, "heads/#{name}", new_commit.sha)
  end

  def edit_branch(repository_full_name, branch_name, description)
    branch = github_client.branch(repository_full_name, branch_name)
    root_sha = branch.commit.sha
    filename = filename_for_new_branch(branch_name)

    new_commit = edit_file_commit(repository_full_name, root_sha, filename, description)
    github_client.update_ref(repository_full_name, "heads/#{branch_name}", new_commit.sha)
  end

  def branches(repository_full_name)
    github_client.branches(repository_full_name)
  end

  def branch(repository_full_name, branch_name)
    github_client.branch(repository_full_name, branch_name)
  end

  def get_feature_at_sha(repository_full_name, sha)
    tree = github_client.tree(repository_full_name, sha)
    features_root = tree.tree.detect { |object| object.path == 'features' }
    subtree = github_client.tree(repository_full_name, features_root.sha)
    blob_root = subtree.tree.first
    Base64.decode64(github_client.blob(repository_full_name, blob_root.sha).content)
  end

  private

  def github_client
    @github_client ||= Octokit::Client.new(access_token: auth_token, auto_paginate: true)
  end

  def create_commit(repo, message, new_tree_sha, root_sha)
    github_client.create_commit(repo, message, new_tree_sha, root_sha)
  end

  def filename_for_new_branch(branch_name)
    "features/#{branch_name.underscore}.feature"
  end

  def create_blob(repo, content)
    github_client.create_blob(repo, Base64.encode64(content), 'base64')
  end

  def file_tree_entry(filename, blob_sha)
    [{
      path: filename,
      mode: '100644',
      type: 'blob',
      sha: blob_sha
    }]
  end

  def create_file_tree(repo, base_tree_sha, filename, content)
    blob_sha = create_blob(repo, content)
    github_client.create_tree(
      repo,
      file_tree_entry(filename, blob_sha),
      base_tree: base_tree_sha
    )
  end

  def edit_file_commit(repo, root_sha, filename, content = '')
    new_tree = create_file_tree(repo, root_sha, filename, content)
    create_commit(repo, "Edited #{filename}", new_tree.sha, root_sha)
  end

  def create_new_file_commit(repo, root_sha, filename, content = '')
    new_tree = create_file_tree(repo, root_sha, filename, content)
    create_commit(repo, "Added #{filename}", new_tree.sha, root_sha)
  end
end
