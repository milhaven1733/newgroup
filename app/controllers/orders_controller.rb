class OrdersController < ApplicationController
  before_action :set_ticket

  def new
    @shipping_address = Adress.new
    @billing_address = Adress.new
    if params[:order]
      cookies[:count] = { value: params[:order][:count], expired: Time.now + 1.hour }
    else
      cookies[:count] = { value: 5, expired: Time.now + 1.hour }
    end
    @order = Order.new(count: cookies[:count], ticket: @ticket, user: current_user)
    @order.calc_amount
  end

  def create
    @order = @ticket.orders.new(order_params
                                .merge(user: current_user, status: :created))
    unless @order.save
      flash[:error] = @order.errors.full_messages.join(', ')
      render :new and return
    end

    pay_order = PayOrder.new(@order)
    if pay_order.pay_bill
      redirect_to mine_order_path(@order), notice: 'Pay your order success'
    else
      flash[:error] = pay_order.errors.full_messages.join(', ')
      render :new and return
    end
  rescue Exception => e
      logger.error("pay bill error: #{e}")
      flash[:error] = 'Order pay failed'
      render :new
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
