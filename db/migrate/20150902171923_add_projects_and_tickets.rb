class AddProjectsAndTickets < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :repository_name
    end

    create_table :projects_users do |t|
      t.references :project, index: true
      t.references :user, index: true
    end
  end
end
