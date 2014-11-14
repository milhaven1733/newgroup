class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :phone
    remove_column :users, :address
    remove_column :users, :is_student
    remove_column :users, :zipcode
    remove_column :users, :group_name
    remove_column :users, :number_of_group_members
    remove_column :users, :university
    remove_column :users, :billing_address
    remove_column :users, :wallet_link
  end
end
