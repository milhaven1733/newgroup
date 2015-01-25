module Mine
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: [:checkout, :show]
    authorize_resource

    def index
      if current_user.normal?
        @orders = current_user.orders.order(id: :desc).page(params[:page]).per_page(20)
      elsif !current_user.verification?
        render :text => "You need verification"
      elsif current_user.merchant?
        @orders = Order.merchant_orders(current_user.id).page(params[:page]).per_page(20)
      end
    end

    def show
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
