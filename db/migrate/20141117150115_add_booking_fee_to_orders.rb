class AddBookingFeeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :booking_fee, :integer
  end
end
