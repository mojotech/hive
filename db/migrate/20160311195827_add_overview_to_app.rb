class AddOverviewToApp < ActiveRecord::Migration
  def change
    add_column :apps, :overview, :text
  end
end
