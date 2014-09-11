class OrdersController < ApplicationController
  before_action :set_ticket

  def create
    @order = @ticket.orders.new(order_params
                                .merge(user: current_user,
                                       price: @ticket.price_when(order_params[:count])))
    if @order.pay_by(current_user)
      redirect_to [:mine, @order]
    else
      redirect_to mine_wallet_path, error: 'Please recharge first'
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find params[:ticket_id]
  end

  def order_params
    params.require(:order).permit(:count)
  end
end
