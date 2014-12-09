class AddOpriceToGroupPrices < ActiveRecord::Migration
  def change
    add_column :group_prices, :oprice, :integer
  end
end
