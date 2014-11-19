class Ticket < ActiveRecord::Base
  CITIES = %w( Philadelphia NewYork )

  priceable :oprice, :shipping, :flat_price

  belongs_to :user
  belongs_to :category
  has_many :group_prices
  has_many :groups, class_name: 'EtGroup'
  has_many :votes, as: :votable
  has_many :orders
  has_one  :time_tag, class_name: 'TimeForTicketSearch', dependent: :destroy

  mount_uploader :image_url, ImageUploader
  mount_uploader :sitting_map, SittingMapUploader

  validates :name, :start_at, :oprice, presence: true
  #validates :start_at, time_period: { scope: :end_at }
  validates :oprice_in_cents, :amount, numericality: true
  validates :student_discount, inclusion: { in: 0..100 }
  validates :city, inclusion: { in: CITIES }
  validates :desc, length: { maximum: 3000 }
  

  after_save :time_parse
  
  scope :search_by, ->(query) do
    joins(:category)
    .where('lower(tickets.name) like :query OR lower(tickets.desc) like :query OR lower(categories.name) like :query', query: "%#{query.downcase}%") 
  end

  delegate :name, to: :category, prefix: true, allow_nil: true

  def self.top_deals
    last(4)
  end
  
  def ranked_group_prices
    group_prices.order(range_from: :asc)
  end

  def ranked_groups
    groups.order(deadline: :asc)
  end

  def price_when(count, for_student = false)
    price = group_price_by(count).try(:price) || oprice
    price = price * (100 - student_discount) / 100 if for_student
    price
  end

  def ticket_enough?(quantity)
    amount >= quantity
  end
  
  def time_parse
    TimeForTicketSearch.create_time_tag(self.id, self.start_at)
  end
  
  def time_range
    if (start_at.to_date <= end_at.to_date) && (end_at > start_at)
      "#{start_at.strftime('%m/%d/%Y')}\n#{start_at.strftime('%H:%M %p')} - #{end_at.strftime('%H:%M %p')}"
    else
      "Invalid ticket time range, Please contact merchant administrator!"
    end
  end

  private
  def group_price_by count
    ranked_group_prices
    .where('range_from <= :count and (range_to >= :count or range_to is null)', count: count)
    .first
  end
end
