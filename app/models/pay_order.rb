class PayOrder
  include ActiveModel::Model
  attr_accessor :balance, :tickets_amount, :tickets_count, :tickets_price, :order

  validates :balance, numericality: { greater_than_or_equal_to: :tickets_price }
  validates :tickets_amount, numericality: { greater_than_or_equal_to: :tickets_count }

  def initialize(order)
    self.order = order
    self.balance = order.user.wallet.balance_in_cents
    self.tickets_amount = order.ticket.amount
    self.tickets_count = order.count
    self.tickets_price = order.amount_in_cents
  end

  def pay_bill
    return false unless self.valid?
    ActiveRecord::Base.transaction do
      order.user.wallet.update!(balance_in_cents: self.balance - tickets_price)
      order.ticket.update!(amount: tickets_amount - tickets_count)
      self.order.update!(status: 'paid')
    end
    true
  end
end
