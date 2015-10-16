class TicketsBelongToLanes < ActiveRecord::Migration
  def change
    remove_column :tickets, :app_id
    add_reference :tickets, :lane, index: true
  end
end
