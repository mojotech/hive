class CreateEpicsTickets < ActiveRecord::Migration
  def change
    create_table :epics_tickets do |t|
      t.references :epic, index: true
      t.references :ticket, index: true
    end
  end
end
