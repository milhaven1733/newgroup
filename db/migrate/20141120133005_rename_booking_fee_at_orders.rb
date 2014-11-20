class RenameBookingFeeAtOrders < ActiveRecord::Migration
  def up
    rename_column :orders, :booking_fee, :booking_fee_in_cents
  end

  def down
    rename_column :orders, :booking_fee_in_cents, :booking_fee
  end
end
