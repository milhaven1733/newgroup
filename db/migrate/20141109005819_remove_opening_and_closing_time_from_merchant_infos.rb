class RemoveOpeningAndClosingTimeFromMerchantInfos < ActiveRecord::Migration
  def change
    remove_column :merchant_infos, :opening_time
    remove_column :merchant_infos, :closing_time
  end
end
