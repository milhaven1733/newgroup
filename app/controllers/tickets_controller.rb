class TicketsController < ApplicationController
  before_action :set_ticket

  def show
    @top_tickets = Ticket.top_deals
  end

  private
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
