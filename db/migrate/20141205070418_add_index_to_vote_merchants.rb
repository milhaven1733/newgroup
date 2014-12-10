class AddIndexToVoteMerchants < ActiveRecord::Migration
  def change
    add_index :vote_merchants, :favorite_venue_id
    add_index :vote_merchants, :voter_id
    add_index :vote_merchants, [:favorite_venue_id, :voter_id], unique: true
  end
end
