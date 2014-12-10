class TicketsController < ApplicationController
  before_action :set_ticket

  def show
    @order = Order.new
    cookies[:flat_price] = @ticket.flat_price(5)
    cookies[:amount] = @ticket.amount
  end

  def like
    fail 'unauth' if current_user.blank?

    voted = params[:voted]
    ticket = Ticket.find(params[:id])

    if voted == 'true'
      ticket.votes.where(user: current_user).try(:first).destroy
    else
      ticket.votes.create!(user: current_user)
    end

    render json: { notice: 'successfully voted' }
  rescue => err
    logger.error("votes transaction error: #{err}")
    render json: { alert: 'something wrong happend!',
                   errors: vote.errors.full_messages }
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
