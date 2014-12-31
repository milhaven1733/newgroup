class UserInfo < ActiveRecord::Base
  validates :user_id, presence: true
  belongs_to :user
  has_one :address, as: :addressable, class_name: 'Adress'
  accepts_nested_attributes_for :address

  def show_address
    address.try(:show_address)
  end
end
