class AddColumnsIntoEtGroups < ActiveRecord::Migration
  def up
    add_column :et_groups, :ticket_id, :integer
    add_column :et_groups, :deadline, :datetime
    add_column :et_groups, :target_amount, :integer
  end

  def down
    remove_column :et_groups, :ticket_id
    remove_column :et_groups, :deadline
    remove_column :et_groups, :target_amount
  end
end
