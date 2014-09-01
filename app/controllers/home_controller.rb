class HomeController < ApplicationController
  def index
  end

  def search
    @current_category = Category.where(id: params[:category_id]).last if params[:category_id]
    @q = Ticket.search(params[:q])
    @q.category_id_eq = @current_category.id if @current_category
    @tickets = @q.result(distinct: true).page(params[:page])
  end
end
