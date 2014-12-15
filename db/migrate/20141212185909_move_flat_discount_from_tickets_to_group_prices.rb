class MoveFlatDiscountFromTicketsToGroupPrices < ActiveRecord::Migration
  def change
    remove_column :tickets, :flat_discount
    add_column :group_prices, :discount, :integer
  end
end
