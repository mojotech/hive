class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :ticket
      t.text :text
    end
    add_index :comments, :ticket_id
  end
end
