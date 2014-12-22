class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket
  belongs_to :shipping_address, class_name: 'Adress', dependent: :destroy
  belongs_to :billing_address, class_name: 'Adress', dependent: :destroy

  priceable :price, :shipping, :amount, :booking_fee

  enum status: [:created, :paid]

  validates :user_id, :ticket_id, :count, :shipping_address, :billing_address, presence: true
  validates :count, numericality: { greater_than_or_equal_to: ->(order) { order.ticket.try(:minimum_amount) || 5 } }
  validates :count, :amount, numericality: { greateer_than: 0 }

  accepts_nested_attributes_for :shipping_address, :billing_address

  PayByResult = [:sucess, :not_enough_money, :not_enough_tickets, :not_ready]

  scope :merchant_orders, ->(user_id) { self.joins(:ticket).where(tickets: { user_id: user_id }) }

  before_create :calc_amount, if: 'amount == 0.0'

  def calc_amount
    set_price
    set_shipping_fee
    self.booking_fee ||= 0
    self.count ||= 0
    self.amount = price * count + shipping + booking_fee
  end

  def set_price
    self.price = ticket.flat_price(count, user.user_info.try(:is_student))
  end

  def set_shipping_fee
    self.shipping = (shipping_fee_included? ? ticket.shipping : 0) || 0
  end

  def shipping_fee_included?
    !will_call
  end
end
