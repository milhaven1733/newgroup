module Mine
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: :checkout
    
    def index
      if current_user.normal?
        @orders = current_user.orders.order(id: :desc).page(params[:page]).per(20)
      elsif current_user.merchant?
        @orders = Order.merchant_orders(current_user.id).page(params[:page]).per(20)
      end
    end

    def show
      @order = current_user.orders.find params[:id]
    end
    
    def create
      @order = current_user.orders.new(order_params.merge(status: :created))
      @order.calc_amount

      if @order.save
        redirect_to action: :checkout, id: @order.id
      else
        flash[:error] = @order.errors.full_messages.join(', ')
        redirect_to ticket_path(order_params[:ticket_id])
      end
    end
    
    def checkout

    end

    def update
      #TODO: Deal with payment thing
    end
    
    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:ticket_id, :count)
    end
    
  end
end
