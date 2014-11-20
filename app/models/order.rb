class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket
  has_one :order_info

  priceable :price, :shipping, :amount, :booking_fee

  enum status: [:created, :paid]

  validates :amount, :user_id, :ticket_id, :price_in_cents, :count, presence: true
  validates :price_in_cents, :amount, numericality: { greater_than: 0 }
  validates :shipping_in_cents, :booking_fee, numericality: true
  validates :count, numericality: { greater_than: 4 }

  before_save :calc_amount, if: 'amount.nil?'
  
  PayByResult = [:sucess, :not_enough_money, :not_enough_tickets]

  def calc_amount
    set_price
    self.shipping_in_cents ||= 0
    self.booking_fee_in_cents ||= 0
    self.amount_in_cents = shipping_fee_included? ? price_in_cents * count + shipping_in_cents + booking_fee_in_cents : price_in_cents * count + booking_fee_in_cents
  end

  def set_price
    count ||= 0
    self.price_in_cents = ticket.price_when(count, user.user_info.try(:is_student)) * 100
  end

  def shipping_fee_included?
    !will_call
  end

  def pay_by(user)
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
