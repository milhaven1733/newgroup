class MerchantInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :user_id, :orgnization, :sales_email, presence: true
  has_one :address, as: :addressable, class_name: 'Adress'
end
