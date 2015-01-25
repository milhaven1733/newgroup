class PayOrder
  include ActiveModel::Model
  attr_accessor :purchase_quantity, :total_price, :order

  validates :total_price, :purchase_quantity, numericality: { greater_than: 0 }
  validates :total_price, numericality: { less_than_or_equal_to: :user_balance }
  validates :purchase_quantity, numericality: { less_than_or_equal_to: :ticket_quantity }

  def initialize(order)
    self.order = order
    self.purchase_quantity = order.count
    self.total_price = order.amount
  end

  def pay_bill
    return false unless self.valid?
    ActiveRecord::Base.transaction do
      pay_order!(total_price)
      minus_purchased_quantity!(purchase_quantity)
      order.paid!
    end
    true
  end

  private
  def pay_order!(order_amount)
    order.user.pay_order!(order_amount)
  end

  def minus_purchased_quantity!(purchase_quantity)
    order.ticket.minus_purchased_quantity!(purchase_quantity)
  end

  def user_balance
    order.user.balance
  end
  
  def ticket_quantity
    order.ticket.amount
  end
end
