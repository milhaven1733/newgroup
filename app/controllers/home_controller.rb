class HomeController < ApplicationController
  helper_method :get_session_city

  def index
    @tickets = Ticket.by_city(get_session_city)
    @top_tickets = @tickets.top_deals
    @tickets_search = TicketsSearch.new
  end

  def search
    @tickets_search = TicketsSearch.new(q_params.merge(user: current_user))
    @tickets = @tickets_search.search_result(get_session_city).try(:page, params[:page])
  end

  def set_city
    set_session_city(params[:city])
    redirect_to action: 'index'
  end

  def about_us

  end

  private

  def set_session_city(city)
    session[:city] = city
  end

  def get_session_city
    session[:city] || 'Philadelphia'
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
