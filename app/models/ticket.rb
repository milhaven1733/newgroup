class Ticket < ActiveRecord::Base
  priceable :oprice

  belongs_to :user
  belongs_to :category
  has_many :group_prices

  # mount_uploader :image_url, ImageUploader

  validates :name, :start_at, :end_at, :oprice, presence: true
  validates :start_at, time_period: { scope: :end_at }
  validates :oprice_in_cents, :amount, numericality: true

  delegate :name, to: :category, prefix: true, allow_nil: true
end
