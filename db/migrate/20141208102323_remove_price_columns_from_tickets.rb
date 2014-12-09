class RemovePriceColumnsFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :oprice_in_cents, :integer
    remove_column :tickets, :student_discount, :integer
  end
end
