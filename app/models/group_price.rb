class GroupPrice < ActiveRecord::Base
  priceable :price

  belongs_to :ticket

  validates :range_from, :range_to, :discount, presence: true, numericality: true
  validates :range_to, numericality: { greater_than: :range_from }
  validates :discount, inclusion: { in: 0..100 }
  delegate :oprice, to: :ticket, allow_nil: true

  def count_range
    "#{ range_from } to #{ range_to }"
  end

  def price
    (oprice ? oprice * (100 - discount) / 100 : 0).round 2
  end
  ##
  # Is this count in this price tier?
  #
  def in_range?(count)
    (range_from..range_to).to_a.include?(count)
  end
end
