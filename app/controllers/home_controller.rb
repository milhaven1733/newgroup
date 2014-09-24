class HomeController < ApplicationController
  before_action :save_search_conditions, only: [:index, :search]
  helper_method :get_session_city
  
  def index
    @tickets = tickets_of_current_city
    @top_tickets = tickets_of_current_city.top_deals
  end

  def filter
    @q = Ticket.search(params[:q])
    date_time_for_filter
    oprice_for_filter
    @tickets = @q.result(distinct: true).page(params[:page])
  end

  def search
    if params[:city]
      set_session_city(params[:city])
      @tickets = tickets_of_current_city.page(params[:page])
    elsif params[:q]
      filter
    else
    @tickets = tickets_of_current_city.page(params[:page])      
    end
    @top_tickets = tickets_of_current_city.top_deals
  end
  
  private

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
      @q.time_tag_date_gteq = process_date_param(params[:q][:time_tag_date_gteq]) if params[:q][:time_tag_date_gteq]
      @q.time_tag_date_lteq = process_date_param(params[:q][:time_tag_date_lteq]) if params[:q][:time_tag_date_lteq]
      @q.time_tag_time_gteq = process_time_param(params[:q][:time_tag_time_gteq]) if params[:q][:time_tag_time_gteq]
      @q.time_tag_time_lteq = process_time_param(params[:q][:time_tag_time_lteq]) if params[:q][:time_tag_time_lteq]
    rescue
      flash[:notice] = "Invalid Date Format"
    end
  end
  
  def oprice_for_filter
    @q.oprice_in_cents_lteq = params[:q][:oprice_in_cents_lteq].to_f * 100 if params[:q] && params[:q][:oprice_in_cents_lteq].present?
    @q.oprice_in_cents_gteq = params[:q][:oprice_in_cents_gteq].to_f * 100 if params[:q] && params[:q][:oprice_in_cents_gteq].present?
  end
  
  def process_date_param(date)
    Date.parse(date).strftime("%Y%m%d")
  end
  
  def process_time_param(time)
    Time.parse(time).strftime("%H%M")
  end
  
  def save_search_conditions
    @search_conditions = {'name_cont' => "", 
                          'category_name_cont' => "",
                          'time_tag_date_gteq' => "",
                          'time_tag_date_lteq' => "",
                          'time_tag_time_gteq' => "", 
                          'time_tag_time_lteq' => "",
                          'oprice_in_cents_gteq' => "",
                          'oprice_in_cents_lteq' => "",
                          'amount_gteq' => ""
                          }
    @search_conditions.deep_merge!(params[:q]) if params[:q]
  end
end
