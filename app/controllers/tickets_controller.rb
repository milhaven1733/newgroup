class TicketsController < ApplicationController
  before_action :set_ticket
  authorize_resource

  def show
    @order = Order.new
    @tickets_search = TicketsSearch.new

    respond_to do |format|
      format.html { render 'show.html.erb' }
      format.mobile { render 'show.mobile.slim' }
    end
  end

  def like
    ticket = Ticket.find(params[:id])
    if current_user.tickets_voted?(ticket)
      current_user.favourites.delete(ticket)
    else
      current_user.favourites << ticket
    end
    respond_to do |format|
      format.js
    end
  end

  #TODO need to refator
  def calc_price
    count = params[:count].to_i
    @valid = count > 0 && (@ticket.amount - count) >= 0
    @flat_price = @ticket.flat_price(count, current_user.try(:is_student))
    @total_price = (@flat_price * count).round(2)
    respond_to do |format|
      format.js
      format.mobile { render template: 'tickets/calc_price.js.erb' }
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
