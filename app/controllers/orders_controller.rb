class OrdersController < ApplicationController
  before_action :set_ticket

  def new
    @shipping_address = Adress.new
    @billing_address = Adress.new
    if params[:order]
      cookies[:count] = { value: params[:order][:count], expired: Time.now + 1.hour }
    end
    @order = Order.new(count: cookies[:count], ticket: @ticket, user: current_user)
    @order.calc_amount
  end

  def create
    @order = @ticket.orders.new(order_params
                                .merge(user: current_user))
    @order.calc_amount
    result = @order.pay_by(current_user)
    if result == Order::PayByResult[0]
      redirect_to [:mine, @order]
    elsif result == Order::PayByResult[1]
      redirect_to mine_wallet_path, error: 'Please recharge first'
    elsif result == Order::PayByResult[2]
      flash[:error] = "Not enough tickets"
      redirect_to @ticket
    elsif result == Order::PayByResult[3]
      flash[:error] = @order.errors.full_messages.join(', ')
      render :new
    else
      redirect_to @ticket
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find params[:ticket_id]
  end

  def order_params
    params.require(:order).permit(:count, :will_call,
                                  shipping_address_attributes: [:first, :second, :state, :zipcode, :city],
                                  billing_address_attributes: [:first, :second, :state, :zipcode, :city] )
  end
end
