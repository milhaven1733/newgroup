class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.integer :user_id
      t.integer :dollar_in_cents

      t.timestamps
    end
  end
end
