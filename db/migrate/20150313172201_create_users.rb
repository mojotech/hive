class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_user_id, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :auth_token, null: false

      t.timestamps null: false
    end
  end
end
