class Transaction < ActiveRecord::Base
  priceable :dollar

  enum transaction_type: [:recharge, :withdraw]
  enum status: [:created, :success]

  belongs_to :user
  has_one :wallet, through: :user

  validates :user_id, :dollar, :transaction_type, presence: true

  before_save :update_wallet, if: :success?

  private

  def update_wallet 
    fail 'missing according wallet' unless wallet
    balance = user.balance

    if recharge?
      wallet.update! balance: balance + dollar
    elsif withdraw?
      fail 'Balance less than withdraw amount' if balance < dollar
      wallet.update! balance: balance - dollar
    end
  end 
end
