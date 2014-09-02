class GroupsUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :et_group
end
