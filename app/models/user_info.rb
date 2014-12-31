class UserInfo < ActiveRecord::Base
  validates :user_id, presence: true
  belongs_to :user
  has_one :address, as: :addressable, class_name: 'Adress'
  accepts_nested_attributes_for :address
end
