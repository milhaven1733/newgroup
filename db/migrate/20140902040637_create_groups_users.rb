class CreateGroupsUsers < ActiveRecord::Migration
  def change
    create_table :groups_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :et_group, index: true

      t.timestamps
    end
  end
end
