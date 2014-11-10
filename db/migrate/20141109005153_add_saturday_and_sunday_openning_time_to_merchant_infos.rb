class AddSaturdayAndSundayOpenningTimeToMerchantInfos < ActiveRecord::Migration
  def change
    add_column :merchant_infos, :workday_opening_time, :string
    add_column :merchant_infos, :sat_opening_time, :string
    add_column :merchant_infos, :sun_opening_time, :string
  end
end
