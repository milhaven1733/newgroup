class EtGroup < ActiveRecord::Base
  belongs_to :leader, class_name: 'User'
  has_many :groups_users
end
