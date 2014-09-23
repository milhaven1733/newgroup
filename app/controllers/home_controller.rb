class HomeController < ApplicationController
  def index
    @tickets = Ticket.all
    @top_tickets = Ticket.top_deals
  end

  def filter
    @current_category = Category.where(id: params[:category_id]).last if params[:category_id]
    @q = Ticket.search(params[:q])
    begin
      @q.time_tag_date_gteq = process_date_param(params[:q][:time_tag_date_gteq]) if params[:q][:time_tag_date_gteq]
      @q.time_tag_date_lteq = process_date_param(params[:q][:time_tag_date_lteq]) if params[:q][:time_tag_date_lteq]
      @q.time_tag_time_gteq = process_time_param(params[:q][:time_tag_time_gteq]) if params[:q][:time_tag_time_gteq]
      @q.time_tag_time_lteq = process_time_param(params[:q][:time_tag_time_lteq]) if params[:q][:time_tag_time_lteq]
    rescue
      redirect_to :search, notice: "Invalid Date Format"
      return
    end
    @q.category_id_eq = @current_category.id if @current_category
    @q.oprice_in_cents_lteq = params[:q][:oprice_in_cents_lteq].to_f * 100 if params[:q] && params[:q][:oprice_in_cents_lteq].present?
    @q.oprice_in_cents_gteq = params[:q][:oprice_in_cents_gteq].to_f * 100 if params[:q] && params[:q][:oprice_in_cents_gteq].present?
    @tickets = @q.result(distinct: true).page(params[:page])
    @top_tickets = Ticket.top_deals
    render :search    
  end

  def search
    @query = params[:query]
    if @query
      @tickets = Ticket.search_by(@query).distinct.page(params[:page])
    else
      @tickets = Ticket.all.page(params[:page])
    end
    @top_tickets = Ticket.top_deals
  end
  
  private
  
  def process_date_param(date)
    Date.parse(date).strftime("%Y%m%d")
  end
  
  def process_time_param(time)
    Time.parse(time).strftime("%H%M")
  end
end
