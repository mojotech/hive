class AddPointsToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :points, :int
  end
end
