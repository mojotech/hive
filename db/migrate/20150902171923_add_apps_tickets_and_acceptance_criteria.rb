class AddAppsTicketsAndAcceptanceCriteria < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :repository_name
    end

    create_table :apps_users do |t|
      t.references :app, index: true
      t.references :user, index: true
    end

    create_table :acceptance_criteria do |t|
      t.references :ticket, index: true
      t.string :description
    end

    create_table :tickets do |t|
      t.references :app, index: true
      t.string :type
      t.text :description
    end
  end
end
