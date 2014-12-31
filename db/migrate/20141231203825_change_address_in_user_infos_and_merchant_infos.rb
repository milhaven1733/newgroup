class ChangeAddressInUserInfosAndMerchantInfos < ActiveRecord::Migration
  def change
    remove_column :user_infos, :address
    remove_column :merchant_infos, :address
  end
end
