class TicketsSearch
  #This class is for ticket search form
  include ActiveModel::Model
  attr_accessor :name_cont, :category_id_eq, :time_tag_date_gteq, :time_tag_date_lteq, :query,
    :time_tag_time_gteq, :time_tag_time_lteq, :oprice_gteq, :oprice_lteq, :amount_gteq, :q_params

  def initialize(q_params = nil)
    if q_params
      q_params.each { |key, value| self.send("#{key}=", value) }
      self.q_params = q_params
    end
  end

  def search_result city = 'Philadelphia'
    if q_params[:query]
      @tickets = Ticket.search_by(q_params[:query])
    else
      date_time_for_filter
      q = Ticket.by_city(city).search(q_params)
      @tickets = q.result(distinct: true)
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
    Date.parse(date).strftime("%Y%m%d")
  end

  def process_time_param(time)
    Time.parse(time).strftime("%H%M")
  end
end