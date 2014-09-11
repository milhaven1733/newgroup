class GroupPrice < ActiveRecord::Base
   priceable :price

   belongs_to :ticket

   validates :range_from, :price_in_cents, presence: true, numericality: true
end
