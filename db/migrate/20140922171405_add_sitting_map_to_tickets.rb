class AddSittingMapToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :sitting_map, :string
  end
end
