class TicketsSearch
  include ActiveModel::Model
  attr_accessor :name_cont, :category_id_eq, :time_tag_date_gteq, :time_tag_date_lteq,
    :time_tag_time_gteq, :time_tag_time_lteq, :oprice_in_cents_gteq, :oprice_in_cents_lteq, :amount_gteq

  def initialize(q_params = nil)
    if q_params
      q_params.each { |key, value| self.send("#{key}=", value) }
    end
  end

  private

  def date_time_for_filter
    self.time_tag_date_gteq = process_date_param(time_tag_date_gteq)
    self.time_tag_date_lteq = process_date_param(time_tag_date_lteq)
    self.time_tag_time_gteq = process_time_param(time_tag_time_gteq)
    self.time_tag_time_lteq = process_time_param(time_tag_time_lteq)
  rescue
  end

  def oprice_for_filter
    self.oprice_in_cents_lteq = oprice_in_cents_lteq.to_f * 100 if oprice_in_cents_lteq.present?
    self.oprice_in_cents_gteq = oprice_in_cents_gteq.to_f * 100 if oprice_in_cents_gteq.present?
  end

  def process_date_param(date)
    Date.parse(date).strftime("%Y%m%d")
  end

  def process_time_param(time)
    Time.parse(time).strftime("%H%M")
  end
end
