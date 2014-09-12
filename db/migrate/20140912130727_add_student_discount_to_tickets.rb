class AddStudentDiscountToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :student_discount, :integer, default: 0
    add_column :tickets, :city, :string
  end
end
