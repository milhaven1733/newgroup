class RemoveColumnsFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :flat_price_in_cents, :integer
    remove_column :tickets, :flat_discount, :integer
  end
end
