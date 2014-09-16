class AddShippingFeeToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :shipping_in_cents, :integer
  end
end
