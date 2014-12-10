class AlterOpriceInGroupPrices < ActiveRecord::Migration
  def change
    remove_column :group_prices, :oprice,         :integer
    add_column    :group_prices, :oprice_in_cents, :integer
  end
end
