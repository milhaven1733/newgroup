class EtGroup < ActiveRecord::Base
  has_and_belongs_to_many :members, join_table: 'groups_users', class_name: 'User' 
  belongs_to :leader, foreign_key: 'leader_id'
end
