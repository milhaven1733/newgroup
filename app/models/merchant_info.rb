class MerchantInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  validates :latitude, :longitude, :user_id, :workday_opening_time, :sat_opening_time, :sun_opening_time, presence: true
  
end
