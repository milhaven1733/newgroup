class HomeController < ApplicationController 
  def index 
    @tickets = Ticket.all
    @top_tickets = Ticket.top_deals
  end
end
