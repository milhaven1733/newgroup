class RemoveEndAtFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :end_at
  end
end
