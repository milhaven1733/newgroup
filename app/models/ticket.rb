class Ticket < ActiveRecord::Base
  CITIES = %w( Philadelphia NewYork )

  priceable :oprice, :shipping

  belongs_to :user
  belongs_to :category
  has_many :group_prices
  has_many :groups, class_name: 'EtGroup'
  has_many :votes, as: :votable
  has_many :orders
  has_one  :time_tag, class_name: 'TimeForTicketSearch', dependent: :destroy

  mount_uploader :image, ImageUploader
  mount_uploader :sitting_map, SittingMapUploader

  validates :minimum_amount, :amount, :name, :start_at, :end_at, :oprice, :city, :category_id,
               :shipping, presence: true
  validates :start_at, time_period: { scope: :end_at }
  validates :oprice, numericality: {  greater_than: 0 }
  validates :shipping, numericality: { greater_than_or_equal_to: 0 }
  validates :city, inclusion: { in: CITIES }
  validates :desc, length: { maximum: 3000 }
  validates :student_discount, inclusion: { in: 0..100 }, allow_nil: true
  validates :minimum_amount, numericality: { greater_than_or_equal_to: 5 }

  accepts_nested_attributes_for :group_prices, allow_destroy: true

  after_save :time_parse

  scope :search_by_count, ->(count = 5) do
    joins(:group_prices)
    .where(':count BETWEEN group_prices.range_from AND group_prices.range_to', count: count)
  end

  scope :search_by_price_range, ->(price_from, price_to, count, is_student = false) do
    price_from ||= 0
    price_to ||= 10000
    if is_student
      search_by_count(count)
      .where('ROUND((100.0 - group_prices.discount - tickets.student_discount) / 100 * tickets.oprice_in_cents / 100, 2) BETWEEN :price_from AND :price_to', price_from: price_from, price_to: price_to)
    else
      search_by_count(count)
      .where('ROUND((100.0 - group_prices.discount) / 100 * tickets.oprice_in_cents / 100, 2) BETWEEN :price_from AND :price_to', price_from: price_from, price_to: price_to)
    end
  end

  scope :search_by, ->(query) do
    joins(:category)
    .where('lower(tickets.name) like :query OR lower(tickets.desc) like :query OR lower(categories.name) like :query', query: "%#{query.downcase}%")
  end
  scope :by_city, ->(city) { where(city: city) }

  delegate :name, to: :category, prefix: true, allow_nil: true

  self.per_page = 6

  def self.top_deals
    last(6).reverse
  end

  def ranked_group_prices
    group_prices.order(range_from: :asc)
  end

  def ranked_groups
    groups.order(deadline: :asc)
  end

  def price_when(count, for_student = false)
    price = group_price_by(count).try(:price) || flat_price || oprice
    price = price * (100 - student_discount) / 100 if for_student
    price
  end

  def ticket_enough?(quantity)
    amount >= quantity
  end

  def time_parse
    TimeForTicketSearch.create_time_tag(self.id, self.start_at)
  end

  def time_range(type = :number)
    if (start_at and end_at) and (start_at.to_date <= end_at.to_date) && (end_at > start_at)
      if type == :number
        "#{start_at.strftime('%m/%d/%Y')}<br>#{start_at.strftime('%H:%M %p')} - #{end_at.strftime('%H:%M %p')}".html_safe
      elsif type == :word
        "#{start_at.strftime('%B %d, %Y')}<br>#{start_at.strftime('%H:%M %p')} - #{end_at.strftime('%H:%M %p')}".html_safe
      end
    else
      "Invalid ticket time range, Please contact merchant administrator!"
    end
  end

  def sold
    self.orders.where(status: :paid).sum(:count)
  end

  def flat_price count = 5, for_student = false
    fp = (for_student ? group_price_for_student(count) : group_price_by(count).try(:price)) || oprice
    fp.round 2
  end

  def flat_discount count = 5, for_student = false
    (for_student ? flat_discount_for_student(count) : group_price_by(count).try(:discount)) || 0
  end

  private
  def group_price_by count
    ranked_group_prices
    .where('range_from <= :count and (range_to >= :count or range_to is null)', count: count)
    .first
  end

  def group_price_for_student count
    oprice * (100 - flat_discount_for_student(count)) / 100
  end

  def flat_discount_for_student count
    if gp = group_price_by(count)
      gp.discount + student_discount
    else
      0
    end
  end
end
