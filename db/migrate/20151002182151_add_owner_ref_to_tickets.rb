class AddOwnerRefToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :owner, index: true
  end
end
