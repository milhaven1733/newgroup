class AddWillCallToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :will_call, :boolean
  end
end
