class TicketsSearch
  #This class is for ticket search form
  include ActiveModel::Model
  attr_accessor :name_cont, :category_id_eq, :time_tag_date_gteq, :time_tag_date_lteq, :query,
    :time_tag_time_gteq, :time_tag_time_lteq, :oprice_gteq, :oprice_lteq, :amount_gteq, :q_params, :user

  validates :amount_gteq, :oprice_lteq, :oprice_gteq, numericality: { greater_than: 0 }, allow_nil: true

  def initialize(q_params = nil)
    if q_params
      q_params.each { |key, value| self.send("#{key}=", value.present? ? value : nil) }
      q_params.delete('oprice_lteq')
      q_params.delete('oprice_gteq')
      self.q_params = q_params
    end
  end

  def search_result city = 'Philadelphia'
    if q_params[:query]
      @tickets = Ticket.search_by(q_params[:query])
    else
      return Ticket.none unless self.valid?
      date_time_for_filter
      q = Ticket.by_city(city).search(q_params)
      @tickets = q.result(distinct: true)
      @tickets = @tickets.search_by_price_range(oprice_gteq, oprice_lteq, amount_gteq, user.try(:is_student))
    end
  end

  private

  def date_time_for_filter
    self.q_params[:time_tag_date_gteq] = process_date_param(time_tag_date_gteq)
    self.q_params[:time_tag_date_lteq] = process_date_param(time_tag_date_lteq)
    self.q_params[:time_tag_time_gteq] = process_time_param(time_tag_time_gteq)
    self.q_params[:time_tag_time_lteq] = process_time_param(time_tag_time_lteq)
  rescue
  end

  def process_date_param(date)
    Date.strptime(date, '%m/%d/%Y').strftime('%Y%m%d')
  end

  def process_time_param(time)
    Time.parse(time).strftime("%H%M")
  end
end
