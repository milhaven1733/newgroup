class CreateVoteMerchants < ActiveRecord::Migration
  def change
    create_table :vote_merchants do |t|
      t.integer :favorite_venue_id
      t.integer :voter_id
      
      t.timestamps null: false
    end
  end
end
