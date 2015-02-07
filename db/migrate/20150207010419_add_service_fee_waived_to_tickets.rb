class AddServiceFeeWaivedToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :service_fee_waived, :boolean, default: false
  end
end
