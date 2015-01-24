class CreateFeatureTickets < ActiveRecord::Migration
  def change
    create_table :feature_tickets do |t|
      t.references :ticket, index: true
      t.string :slider_image
      t.integer :image_sort

      t.timestamps null: false
    end
    add_foreign_key :feature_tickets, :tickets
  end
end
