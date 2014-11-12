class AddColomnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :group_name, :string
    add_column :users, :number_of_group_members, :integer
    add_column :users, :university, :string
    add_column :users, :billing_address, :string
    add_column :users, :wallet_link, :string
  end
end
