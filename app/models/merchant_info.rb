class MerchantInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  validates :user_id, :orgnization, :sales_email, presence: true
  validates :phone, :sales_phone, numericality: { only_integer: true }, length: {is: 10}

end
