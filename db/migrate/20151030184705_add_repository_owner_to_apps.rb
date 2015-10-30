class AddRepositoryOwnerToApps < ActiveRecord::Migration
  def change
    add_column :apps, :repository_owner, :string
  end
end
