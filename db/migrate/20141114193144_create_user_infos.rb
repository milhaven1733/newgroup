class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :phone
      t.string :address
      t.boolean :is_student
      t.string :zipcode
      t.string :group_name
      t.integer :number_of_group_members
      t.string :university
      t.string :billing_address
      t.string :wallet_link

      t.timestamps null: false
    end
  end
end
