class GroupPrice < ActiveRecord::Base
  priceable :price

  belongs_to :ticket

  validates :range_from, :price_in_cents, presence: true, numericality: true

  def count_range
    "#{ range_from } to #{ range_to }"
  end
end
