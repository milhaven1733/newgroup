class AddColumnsIntoEtGroups < ActiveRecord::Migration
  def change
    add_column :et_groups, :ticket_id, :integer
    add_column :et_groups, :deadline, :datetime
    add_column :et_groups, :target_amount, :integer
  end
end
