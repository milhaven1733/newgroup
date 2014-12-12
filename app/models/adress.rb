class Adress < ActiveRecord::Base
   belongs_to :addressable, polymorphic: true
   validates :first, :city, :state, :zipcode, presence: true
end
