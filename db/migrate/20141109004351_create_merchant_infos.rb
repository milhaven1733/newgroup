class CreateMerchantInfos < ActiveRecord::Migration
  def change
    create_table :merchant_infos do |t|
      t.integer :user_id
      t.float :longitude
      t.float :latitude
      t.datetime :opening_time
      t.datetime :closing_time
      t.string :url

      t.timestamps null: false
    end
  end
end
