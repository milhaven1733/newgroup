class Wallet < ActiveRecord::Base 
  belongs_to :user

  priceable :dollar

  def afford?(price)
    dollar >= price
  end
end
