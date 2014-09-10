class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :token
      t.string :customer_id
      t.integer :transaction_type, default: 0
      t.integer :dollar_in_cents
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
