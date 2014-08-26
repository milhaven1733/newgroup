class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.string :name
      t.string :name
      t.text :desc
      t.datetime :start_at
      t.datetime :end_at
      t.string :image_url
      t.integer :oprice_in_cents
      t.integer :amount

      t.timestamps
    end
  end
end
