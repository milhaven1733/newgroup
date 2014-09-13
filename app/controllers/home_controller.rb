class HomeController < ApplicationController
  def index
    @tickets = Ticket.all
    @top_tickets = Ticket.top_deals
  end

  def filter
    @current_category = Category.where(id: params[:category_id]).last if params[:category_id]
    @q = Ticket.search(params[:q])
    @q.category_id_eq = @current_category.id if @current_category
    @q.oprice_in_cents_lteq = params[:q][:oprice_in_cents_lteq].to_f * 100 if params[:q] && params[:q][:oprice_in_cents_lteq].present?
    @q.oprice_in_cents_gteq = params[:q][:oprice_in_cents_gteq].to_f * 100 if params[:q] && params[:q][:oprice_in_cents_gteq].present?
    @tickets = @q.result(distinct: true).page(params[:page])
    render :search
  end

  def search
    @query = params[:query]
    @tickets = Ticket.search_by(@query).distinct.page(params[:page])
  end
end
