class AddRequesterToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :requester_id, :integer, index: true
  end
end
