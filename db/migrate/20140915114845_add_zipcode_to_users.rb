class AddZipcodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zipcode, :string
    add_column :users, :genre, :string
  end
end
