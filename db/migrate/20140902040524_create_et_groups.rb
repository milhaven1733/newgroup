class CreateEtGroups < ActiveRecord::Migration
  def change
    create_table :et_groups do |t|
      t.string :name
      t.integer :leader_id

      t.timestamps
    end
  end
end
