class AddProjectsAndTickets < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :repository_name
    end

    create_table :apps_users do |t|
      t.references :project, index: true
      t.references :user, index: true
    end

    create_table :tickets do |t|
      t.references :project, index: true
      t.string :type
      t.text :description
    end
  end
end
