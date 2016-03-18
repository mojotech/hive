class CreateEpics < ActiveRecord::Migration
  def change
    create_table :epics do |t|
      t.string :name
      t.references :app, index: true

      t.timestamps null: false
    end
  end
end
