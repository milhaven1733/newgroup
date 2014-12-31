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
  has_many :merchant_votes, as: :votable, class_name: 'Vote'
  has_many :favorite_merchant_votes, -> { where(votes: {votable_type: 'User'}) }, foreign_key: :user_id, class_name: 'Vote'
  has_many :favorite_merchants, through: :favorite_merchant_votes

  accepts_nested_attributes_for :merchant_info
  accepts_nested_attributes_for :user_info

  #validates :email, format: { 
    #with: /\.edu\Z/, 
    #message: 'student account must regirster with .edu email' 
  #}, if: :is_student

  before_create :default_role
  after_create :init_wallet

  delegate :balance, :balance=, :afford?, to: :wallet

  def address
    if merchant?
      merchant_info.try(:address).try(:show_address)
    else
      user_info.try(:address).try(:show_address)
    end
  end

  def avatar_url
    avatar.try(:url) || 'avatar.png'
  end

  def can_withdraw?
    balance > 0.0
  end

  def increment_balance(amount)
    update! balance: balance - amount
  end

  def voted?(other)
    favorite_merchants.include?(other)
  end

  def tickets_voted?(other)
    favourites.include?(other)
  end

  def is_student
    user_info.try(:is_student) || student_email_valid?
  end

  def top_deals
    tickets.last(6).reverse
  end

  def more_tickets
    tickets - top_deals
  end

  def student_email_valid?
    email.match(/\.edu\Z/) ? true : false
  end

  private

  def default_role
    self.role = :normal unless self.role
  end

  def init_wallet
    create_wallet(balance: 0)
  end
end
