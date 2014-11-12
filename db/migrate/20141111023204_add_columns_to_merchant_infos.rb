class AddColumnsToMerchantInfos < ActiveRecord::Migration
  def change
    add_column :merchant_infos, :orgnization, :string
    add_column :merchant_infos, :sales_email, :string
    add_column :merchant_infos, :sales_phone, :string
  end
end
