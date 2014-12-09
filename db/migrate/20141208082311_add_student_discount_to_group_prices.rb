class AddStudentDiscountToGroupPrices < ActiveRecord::Migration
  def change
    add_column :group_prices, :student_discount, :integer
  end
end
