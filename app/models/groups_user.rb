class GroupsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :et_group

  enum status: [:joined, :paid]

  validates :user_id, uniqueness: { scope: :et_group_id, message: 'Have Join the group' }
end
