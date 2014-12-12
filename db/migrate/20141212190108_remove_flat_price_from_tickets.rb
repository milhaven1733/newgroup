class RemoveFlatPriceFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :flat_price_in_cents, :integer
  end
end
