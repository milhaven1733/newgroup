class MoveGenreFromUsersToMerchantInfos < ActiveRecord::Migration
  def change
    remove_column :users, :genre
    add_column :merchant_infos, :category_id, :integer
  end
end
