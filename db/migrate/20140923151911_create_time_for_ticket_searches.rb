class CreateTimeForTicketSearches < ActiveRecord::Migration
  def change
    create_table :time_for_ticket_searches do |t|
      t.integer :ticket_id
      t.integer :date
      t.integer :time

      t.timestamps null: false
    end
  end
end
