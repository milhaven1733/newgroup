class AddTicketIdToMerchantInfos < ActiveRecord::Migration
  def change
    add_column :merchant_infos, :ticket_id, :integer
  end
end
