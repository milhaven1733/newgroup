class Wallet < ActiveRecord::Base 
  belongs_to :user

  priceable :balance

  def afford?(price)
    dollar >= price
  end
end
