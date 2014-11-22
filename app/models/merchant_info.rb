class MerchantInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :user_id, :orgnization, :sales_email, presence: true

end
