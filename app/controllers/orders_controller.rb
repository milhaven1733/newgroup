class OrdersController < ApplicationController
  before_action :set_ticket

  def create
    @order = @ticket.orders.new(order_params
                                .merge(user: current_user,
                                       price: @ticket.price_when(order_params[:count]),
                                       shipping: @ticket.shipping))
    result = @order.pay_by(current_user)
    if result == Order::PayByResult[0]
      redirect_to [:mine, @order]
    elsif result == Order::PayByResult[1]
      redirect_to mine_wallet_path, error: 'Please recharge first'
    elsif result == Order::PayByResult[2]
      flash[:error] = "Not enough tickets"
      redirect_to @ticket
    else
      redirect_to @ticket
    end
    
  end

  private

  def set_ticket
    @ticket = Ticket.find params[:ticket_id]
  end

  def order_params
    params.require(:order).permit(:count, :will_call)
  end
end
