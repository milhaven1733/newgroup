class AddDiscountToGroupPrices < ActiveRecord::Migration
  def change
    add_column :group_prices, :discount, :integer
  end
end
