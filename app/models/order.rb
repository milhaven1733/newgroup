class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket
  belongs_to :shipping_address, class_name: 'Adress', dependent: :destroy
  belongs_to :billing_address, class_name: 'Adress', dependent: :destroy

  priceable :price, :shipping, :amount, :booking_fee

  enum status: [:created, :paid]

  validates :amount_in_cents, :user_id, :ticket_id, :price_in_cents, :count,
                :shipping_address, :billing_address, presence: true
  validates :price_in_cents, :amount_in_cents, numericality: { greater_than: 0 }
  validates :shipping_in_cents, :booking_fee_in_cents, numericality: true
  validates :count, numericality: { greater_than_or_equal_to: ->(order) { order.ticket.try(:minimum_amount) || 5 } }

  accepts_nested_attributes_for :shipping_address, :billing_address

  PayByResult = [:sucess, :not_enough_money, :not_enough_tickets, :not_ready]

  scope :merchant_orders, ->(user_id) { self.joins(:ticket).where(tickets: { user_id: user_id }) }

  def calc_amount
    set_price
    set_shipping_fee
    self.booking_fee_in_cents ||= 0
    self.amount_in_cents = price_in_cents * count + shipping_in_cents + booking_fee_in_cents
  end

  def set_price
    self.count ||= 0
    byebug
    self.price_in_cents = ticket.price_when(count, user.try(:user_info).try(:is_student)) * 100
  end

  def set_shipping_fee
    self.shipping_in_cents = (shipping_fee_included? ? ticket.shipping_in_cents : 0) || 0
  end

  def shipping_fee_included?
    !will_call
  end

  def pay_by(user)
    return PayByResult[3] unless self.valid?
    return PayByResult[1] unless user.afford?(amount)
    return PayByResult[2] unless ticket.ticket_enough?(count)
    Order.transaction do
      wallet = Wallet.find_by! user_id: user_id
      wallet.update! balance: user.balance - amount
      ticket.decrement! :amount, count
      self.status = :paid
      self.save!
    end
    PayByResult[0]
  end
end
