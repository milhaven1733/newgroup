class VoteMerchant < ActiveRecord::Base
  belongs_to :favorite_venue, class_name: "User"
  belongs_to :voter, class_name: "User"
  validates :favorite_venue_id, presence: true
  validates :voter_id, presence: true
end
