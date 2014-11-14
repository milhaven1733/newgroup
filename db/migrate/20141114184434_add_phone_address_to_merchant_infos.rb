class AddPhoneAddressToMerchantInfos < ActiveRecord::Migration
  def change
    add_column :merchant_infos, :phone, :string
    add_column :merchant_infos, :address, :string
  end
end
