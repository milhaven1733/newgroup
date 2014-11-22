class DropTableOrderInfo < ActiveRecord::Migration
  def change
    drop_table :order_info
  end
end
