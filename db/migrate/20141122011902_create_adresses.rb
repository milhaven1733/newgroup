class CreateAdresses < ActiveRecord::Migration
  def change
    create_table :adresses do |t|
      t.string :first
      t.string :second
      t.string :zipcode
      t.string :city
      t.string :state
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps null: false
    end
  end
end
