class AddShippingFeeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_in_cents, :integer
  end
end
