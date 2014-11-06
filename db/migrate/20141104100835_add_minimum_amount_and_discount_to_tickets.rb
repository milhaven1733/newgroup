class AddMinimumAmountAndDiscountToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :minimum_amount, :integer
    add_column :tickets, :flat_discount,  :integer
  end
end
