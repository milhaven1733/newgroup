class AddAvatarIntoUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :role, :integer
  end
end
