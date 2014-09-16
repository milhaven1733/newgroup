class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket

  priceable :price, :shipping

  enum status: [:created, :paid]

  validates :user_id, :ticket_id, :price_in_cents, :count, presence: true
  validates :price_in_cents, numericality: { greater_than: 0 }
  validates :count, numericality: { greater_than: 4 }

  def amount
    shipping_fee_included? ? price * count + shipping : price * count
  end

  def shipping_fee_included?
    !will_call
  end
  
  def pay_by(user)
    return false unless user.afford?(amount)
    return false unless ticket.ticket_enough?(count)
    Order.transaction do
      wallet = Wallet.find_by! user_id: user_id
      wallet.update! balance: user.balance - amount
      ticket.decrement! :amount, count
      self.status = :paid
      self.save!
    end
  end
end
