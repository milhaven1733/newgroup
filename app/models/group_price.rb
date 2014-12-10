class GroupPrice < ActiveRecord::Base
  priceable :price, :oprice

  belongs_to :ticket

  validates :range_from, :range_to, :price_in_cents, :discount, :student_discount, presence: true, numericality: true
  validates :discount, :student_discount, inclusion: { in: 0..100 }
  validates :oprice_in_cents, :price_in_cents, numericality: {  greater_than: 0 }

  def count_range
    "#{ range_from } to #{ range_to }"
  end
  
  ##
  # Is this count in this price tier?
  #
  def in_range?(count)
    (range_from..range_to).to_a.include?(count)
  end
end
