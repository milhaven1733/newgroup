class PayOrder
  include ActiveModel::Model
  attr_accessor :balance, :tickets_quantity, :purchase_quantity, :total_price, :order

  validates :balance, numericality: { greater_than_or_equal_to: :total_price }
  validates :tickets_quantity, numericality: { greater_than_or_equal_to: :purchase_quantity }
  validates :total_price, :purchase_quantity, numericality: { greater_than: 0 }

  def initialize(order)
    self.order = order
    self.balance = order.user.wallet.balance
    self.tickets_quantity = order.ticket.amount
    self.purchase_quantity = order.count
    self.total_price = order.amount
  end

  def pay_bill
    return false unless self.valid?
    ActiveRecord::Base.transaction do
      order.user.wallet.update!(balance: self.balance - total_price)
      order.ticket.update!(amount: tickets_quantity - purchase_quantity)
      self.order.update!(status: 'paid')
    end
    true
  end
end
