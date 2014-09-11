class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, ImageUploader

  enum role: [:normal, :merchant]

  has_many :tickets
  has_many :et_groups
  has_and_belongs_to_many :groups, join_table: 'groups_users'
  has_many :votes, foreign_key: :user_id
  has_many :favourites, through: :votes, source: :ticket
  has_one :wallet
  has_many :orders

  after_create :init_wallet

  delegate :balance, :balance=, :afford?, to: :wallet

  def avatar_url
    avatar.try(:url) || "avatar.png"
  end

  def can_withdraw?
    balance > 0.0
  end

  def increment_balance amount
    update! balance: balance - amount
  end

  private
  def init_wallet
    create_wallet(balance: 0)
  end
end
