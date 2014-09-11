class Wallet < ActiveRecord::Base
  belongs_to :user

  priceable :balance

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def afford?(price)
    balance >= price
  end
end
