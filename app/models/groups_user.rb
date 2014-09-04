class GroupsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :et_group

  enum status: [:joined, :paid]

  validates_uniqueness_of :user_id, scope: :et_group_id, message: 'Have Join the group'
end
