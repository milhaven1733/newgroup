class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :ticket_id
      t.integer :count
      t.integer :price_in_cents
      t.integer :amount_in_cents
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
