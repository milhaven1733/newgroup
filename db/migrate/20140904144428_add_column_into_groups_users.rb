class AddColumnIntoGroupsUsers < ActiveRecord::Migration
  def change
    add_column :groups_users, :amount, :integer
    add_column :groups_users, :status, :integer, default: 0
    add_column :groups_users, :id, :primary_key
  end
end
