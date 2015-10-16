class CreateLanes < ActiveRecord::Migration
  def change
    create_table :lanes do |t|
      t.references :app, index: true
      t.string :title
    end
  end
end
