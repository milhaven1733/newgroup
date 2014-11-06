class AddEndAtAndFlatPriceAndWillCallToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :end_at, :datetime
    add_column :tickets, :flat_price_in_cents, :integer
    add_column :tickets, :will_call, :boolean 
  end
end
