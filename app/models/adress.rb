class Adress < ActiveRecord::Base
   belongs_to :addressable, polymorphic: true
   validates :first, :city, :state, :zipcode, presence: true

   def show_address
    first + ', ' + (second ? second + ', ' : '') + city + ', ' + state + ', ' + zipcode
   end
end
