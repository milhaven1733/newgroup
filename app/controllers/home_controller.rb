class HomeController < ApplicationController 
  def index 
    @tickets = Ticket.all
  end
end
