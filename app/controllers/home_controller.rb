class HomeController < ApplicationController
  helper_method :get_session_city

  def index
    @tickets = Ticket.by_city(get_session_city)
    @top_tickets = @tickets.top_deals
    @tickets_search = TicketsSearch.new

    respond_to do |format|
      format.mobile { render "index.mobile.slim" }
      format.html { render "index.html.erb" }
    end
  end

  def search
    @tickets_search = TicketsSearch.new(q_params.merge(user: current_user))
    @tickets = @tickets_search.search_result(get_session_city).try(:page, params[:page])
  end

  def set_city
    set_session_city(params[:city])
    redirect_to root_path
  end

  def about_us
  end
  
  def mobile_search
    @q = Ticket.search(params[:q])

    if params[:q].present?
      @q.oprice_in_cents_lteq = params[:q][:oprice_in_cents_lteq].to_f * 100 if params[:q][:oprice_in_cents_lteq].present?
      @q.oprice_in_cents_gteq = params[:q][:oprice_in_cents_gteq].to_f * 100 if params[:q][:oprice_in_cents_gteq].present?
    end

    @tickets = @q.result
  end

  private

  def set_session_city(city)
    session[:city] = city
  end

  def get_session_city
    #session[:city] || 'Philadelphia'
    session[:city] || 'NewYork'
  end

  def q_params
    params.require(:tickets_search).permit(:name_cont,
                              :category_id_eq,
                              :time_tag_date_gteq,
                              :time_tag_date_lteq,
                              :time_tag_time_gteq,
                              :time_tag_time_lteq,
                              :oprice_gteq,
                              :oprice_lteq,
                              :amount_gteq,
                              :query
                             )
  end
end
