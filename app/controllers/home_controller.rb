class HomeController < ApplicationController
  before_action :save_search_conditions, only: [:index, :search]
  helper_method :get_session_city
  before_action :safty_q_params, only: :search
  SearchParamsName = { name: 'Title', 
    category: 'category_id_eq',
    date_begin: 'Date From',
    date_end: 'Date To',
    time_begin: 'Time From',
    time_end: 'Time To',
    price_begin: 'Price From',
    price_end: 'Price To',
    amount: 'Quantity'
    }
  
  def index
    @tickets = tickets_of_current_city
    @top_tickets = tickets_of_current_city.top_deals
  end

  def filter
    @q = tickets_of_current_city.search(@q_params)
    date_time_for_filter
    oprice_for_filter
    @tickets = @q.result(distinct: true).page(params[:page])
  end

  def search
    if params[:query]
      @query = params[:query]
      @tickets = tickets_of_current_city.search_by(@query).distinct.page(params[:page])
    elsif params[:q]
      filter
    else
      @tickets = tickets_of_current_city.page(params[:page])      
    end
    @top_tickets = tickets_of_current_city.top_deals
  end
  
  def set_city
    set_session_city(params[:city])
    redirect_to action: 'index'
  end
  
  def about_us
    
  end

  private

  def safty_q_params
    @q_params = ActionController::Parameters.new
    @q_params.merge!(search_params) if params[:q]
  end
  
  def set_session_city(city)
     session[:city] = city
  end
  
  def get_session_city
    session[:city] || 'Philadelphia'
  end
  
  def tickets_of_current_city
    Ticket.where(city: get_session_city)
  end
  
  def date_time_for_filter
    begin
      @q.time_tag_date_gteq = process_date_param(@q_params[:time_tag_date_gteq]) if @q_params[:time_tag_date_gteq]
      @q.time_tag_date_lteq = process_date_param(@q_params[:time_tag_date_lteq]) if @q_params[:time_tag_date_lteq]
      @q.time_tag_time_gteq = process_time_param(@q_params[:time_tag_time_gteq]) if @q_params[:time_tag_time_gteq]
      @q.time_tag_time_lteq = process_time_param(@q_params[:time_tag_time_lteq]) if @q_params[:time_tag_time_lteq]
    rescue
      flash[:notice] = "Invalid Date Format"
    end
  end
  
  def oprice_for_filter
    @q.oprice_in_cents_lteq = @q_params[:oprice_in_cents_lteq].to_f * 100 if @q_params[:oprice_in_cents_lteq].present?
    @q.oprice_in_cents_gteq = @q_params[:oprice_in_cents_gteq].to_f * 100 if @q_params[:oprice_in_cents_gteq].present?
  end
  
  def process_date_param(date)
    Date.parse(date).strftime("%Y%m%d")
  end
  
  def process_time_param(time)
    Time.parse(time).strftime("%H%M")
  end
  
  def save_search_conditions
    @search_conditions = HashWithIndifferentAccess.new
    @search_conditions.deep_merge!(search_params) if params[:q]
  end
  
  def search_params
    params.require(:q).permit(SearchParamsName[:name],
                                        SearchParamsName[:category],
                                        SearchParamsName[:date_begin],
                                        SearchParamsName[:date_end],
                                        SearchParamsName[:time_begin], 
                                        SearchParamsName[:time_end],
                                        SearchParamsName[:price_begin],
                                        SearchParamsName[:price_end],
                                        SearchParamsName[:amount]
                                        )
  end
end
