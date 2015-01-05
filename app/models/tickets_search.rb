class TicketsSearch
  #This class is for ticket search form
  include ActiveModel::Model
  attr_accessor :name, :category_id, :date_from, :date_to, :query,
    :time_from, :time_to, :price_from, :price_to, :amount, :user

  validates :amount, :price_from, :price_to, numericality: { greater_than: 0 }, allow_nil: true

  def initialize(q_params = nil)
    if q_params
      q_params.each { |key, value| self.send("#{key}=", value.present? ? value : nil) }
    end
  end

  def search_result city = 'Philadelphia'
    if query
      Ticket.search_by(query)
    else
      return Ticket.none unless self.valid?
      date_time_for_filter
      q = Ticket.by_city(city).search(to_q_hash)
      tickets = q.result(distinct: true)
      tickets.search_by_price_range(price_from, price_to, amount, user.try(:is_student))
    end
  end

  private

  def date_time_for_filter
    self.date_from = process_date_param(date_from)
    self.date_to = process_date_param(date_to)
    self.time_from = process_time_param(time_from)
    self.time_to = process_time_param(time_to)
  rescue
  end

  def process_date_param(date)
    Date.strptime(date, '%m/%d/%Y').strftime('%Y%m%d')
  end

  def process_time_param(time)
    Time.parse(time).strftime("%H%M")
  end

  def to_q_hash
    {name_cont: name, category_id_eq: category_id, time_tag_date_gteq: date_from, time_tag_date_lteq: date_to,
    time_tag_time_gteq: time_from, time_tag_time_lteq: time_to, amount_gteq: amount}
  end
end
