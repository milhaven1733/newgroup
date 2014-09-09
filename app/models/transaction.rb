class Transaction < ActiveRecord::Base
  priceable :dollar

  enum transaction_type: [:recharge, :withdraw]
  enum status: [:created, :success]
end
