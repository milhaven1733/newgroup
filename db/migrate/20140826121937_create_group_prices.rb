class CreateGroupPrices < ActiveRecord::Migration
  def change
    create_table :group_prices do |t|
      t.integer :ticket_id
      t.integer :range_from
      t.integer :range_to
      t.integer :price_in_cents

      t.timestamps
    end
  end
end
