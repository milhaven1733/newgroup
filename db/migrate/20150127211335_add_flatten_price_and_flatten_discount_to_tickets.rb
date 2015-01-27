class AddFlattenPriceAndFlattenDiscountToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :flatten_price_in_cents, :integer
    add_column :tickets, :flatten_discount, :integer
  end
end
