class GroupPrice < ActiveRecord::Base
   priceable :price

   validates :range_from, :range_to, :price_in_cents, presence: true, numericality: true

   def display_price
     "#{range_from}-#{range_to}: $#{price}"
   end
end
