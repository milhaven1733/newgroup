class TimeForTicketSearch < ActiveRecord::Base
  belongs_to :ticket
  validate :ticket_id, presence: true
  
  def self.create_time_tag(ticket_id, datetime)
    raise 'datetime argument is not valid' unless datetime.instance_of?(ActiveSupport::TimeWithZone)
    time_for_ticket_search = find_or_create_by(ticket_id: ticket_id)
    time_for_ticket_search.date = datetime.strftime("%Y%m%d").to_i
    time_for_ticket_search.time = datetime.strftime("%H%M").to_i
    result = time_for_ticket_search.save
    raise 'Time tag save failed' unless result
  end
end
