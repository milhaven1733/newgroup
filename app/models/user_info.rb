class UserInfo < ActiveRecord::Base
  validates :number_of_group_members, numericality: { only_integer: true  }
  validates :phone, numericality: { only_integer: true }, length: {is: 10}
  validates :user_id, presence: true
  belongs_to :user
end
