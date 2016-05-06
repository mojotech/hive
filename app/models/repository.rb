class Repository
  attr_reader :name, :owner_login

  def initialize(name:, owner_login:, auth_token:)
    @name = name
    @owner_login = owner_login
    @auth_token = auth_token
  end

  def full_name
    "#{owner_login}/#{name}"
  end

  def branches
    github_client.branches(full_name)
  end

  def branch(branch_name)
    github_client.branch(full_name, branch_name)
  end

  def html_url
    octokit_repository.html_url
  end

  def description
    octokit_repository.description
  end

  def create_branch(branch_name, filename, description)
    root_sha = github_client.ref(full_name, "heads/#{default_branch_name}").object.sha
    new_commit = create_new_file_commit(root_sha, filename, description)
    github_client.create_ref(full_name, "heads/#{branch_name}", new_commit.sha)
  end

  def edit_branch(branch_name, filename, description)
    branch = github_client.branch(full_name, branch_name)
    root_sha = branch.commit.sha

    new_commit = edit_file_commit(root_sha, filename, description)
    github_client.update_ref(full_name, "heads/#{branch_name}", new_commit.sha)
  end

  def get_feature_at_sha(sha)
    tree = github_client.tree(full_name, sha)
    features_root = tree.tree.detect { |object| object.path == 'features' }
    subtree = github_client.tree(full_name, features_root.sha)
    blob_root = subtree.tree.first
    Base64.decode64(github_client.blob(full_name, blob_root.sha).content)
  end

  def get_diff(branch_name)
    compare(default_branch_name, branch_name)
  end

  private

  def compare(first_commit_name, second_commit_name)
    @github_client.compare(full_name, first_commit_name, second_commit_name)
  end

  def github_client
    @github_client ||= Octokit::Client.new(access_token: @auth_token, auto_paginate: true)
  end

  def octokit_repository
    @octokit_repository ||= github_client.repository(full_name)
  end

  def default_branch_name
    octokit_repository.default_branch
  end

  def filename_for_new_branch(branch_name)
    "features/#{branch_name.underscore}.feature"
  end

  def create_commit(message, new_tree_sha, root_sha)
    github_client.create_commit(full_name, message, new_tree_sha, root_sha)
  end

  def create_blob(content)
    github_client.create_blob(full_name, Base64.encode64(content), 'base64')
  end

  def file_tree_entry(filename, blob_sha)
    [{
      path: filename,
      mode: '100644',
      type: 'blob',
      sha: blob_sha
    }]
  end

  def create_file_tree(base_tree_sha, filename, content)
    blob_sha = create_blob(content)
    github_client.create_tree(
      full_name,
      file_tree_entry(filename, blob_sha),
      base_tree: base_tree_sha
    )
  end

  def edit_file_commit(root_sha, filename, content = '')
    new_tree = create_file_tree(root_sha, filename, content)
    create_commit("Edited #{filename}", new_tree.sha, root_sha)
  end

  def create_new_file_commit(root_sha, filename, content = '')
    new_tree = create_file_tree(root_sha, filename, content)
    create_commit("Added #{filename}", new_tree.sha, root_sha)
  end
end
