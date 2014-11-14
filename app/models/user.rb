class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, ImageUploader

  enum role: [:normal, :merchant]

  has_many :tickets
  has_many :et_groups
  has_many :votes, foreign_key: :user_id
  has_many :favourites, through: :votes, source: :ticket
  has_one :wallet
  has_many :orders
  has_one :merchant_info, dependent: :destroy
  has_one :user_info, dependent: :destroy
  
  accepts_nested_attributes_for :merchant_info
  accepts_nested_attributes_for :user_info

  #validates :email, format: { 
    #with: /\.edu\Z/, 
    #message: 'student account must regirster with .edu email' 
  #}, if: :is_student

  before_create :default_role
  after_create :init_wallet

  delegate :balance, :balance=, :afford?, to: :wallet

  def avatar_url
    avatar.try(:url) || 'avatar.png'
  end

  def can_withdraw?
    balance > 0.0
  end

  def increment_balance(amount)
    update! balance: balance - amount
  end

  private

  def default_role
    self.role = :normal unless self.role
  end

  def init_wallet
    create_wallet(balance: 0)
  end
end
