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
    @tickets_search = TicketsSearch.new(q_params) do |ts|
      ts.user = current_user
    end
    @tickets = @tickets_search.search_result(get_session_city).try(:page, params[:page])
  end

  def set_city
    set_session_city(params[:city])
    redirect_to root_path
  end

  def mobile_search
    @tickets_search = TicketsSearch.new(q_params) do |ts|
      ts.user = current_user
    end
    if q_params.present?
      @tickets = @tickets_search.search_result(get_session_city).try(:page, params[:page])
    else
      @tickets = nil
    end
  end

  private

  def set_session_city(city)
    session[:city] = city
  end

  def get_session_city
    session[:city] || 'Philadelphia'
  end

  def q_params
    if params[:tickets_search]
      params.require(:tickets_search).permit(:name,
                                :category_id,
                                :date_from,
                                :date_to,
                                :time_from,
                                :time_to,
                                :price_from,
                                :price_to,
                                :amount,
                                :query
                               )
    else
      {}
    end
  end
end
