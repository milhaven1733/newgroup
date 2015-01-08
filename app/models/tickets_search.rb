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
      q = Ticket.by_city(city).search(to_q_hash)
      tickets = q.result(distinct: true)
      tickets.search_by_price_range(price_from, price_to, amount, user.try(:is_student))
    end
  end

  private

  def process_date_param(date)
    Date.strptime(date, '%m/%d/%Y')
  rescue
    nil
  end

  def process_time_param(time)
    Time.parse(time)
  rescue
    nil
  end

  def to_q_hash
    {name_cont: name, category_id_eq: category_id, start_at_date_gteq: process_date_param(date_from), start_at_date_lteq: process_date_param(date_to), start_at_time_gteq: process_time_param(time_from), start_at_time_lteq: process_time_param(time_to), amount_gteq: amount}
  end
end
