class CreateOrderInfo < ActiveRecord::Migration
  def change
    create_table :order_infos do |t|
      t.integer :order_id
      t.string :first_address
      t.string :secondary_address
      t.string :city
      t.string :state
      t.string :zipcode
    end
  end
end
