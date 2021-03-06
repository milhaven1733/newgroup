module ApplicationHelper
  def render_date(datetime)
    datetime.try(:to_s, :db)
  end

  def format_datetime(datetime)
    datetime.try(:to_s, :time)
  end

  def liked?(ticket)
    current_user.present? && current_user.tickets_voted?(ticket)
  end
  
  def show_shipping_fee(order)
    order.shipping_fee_included? ? order.shipping_to_currency : "Will Call"
  end
  
  def category_options
    Category.all.map { |category| [category.name, category.id] }
  end
  
  def q_param_name(type)
    HomeController::SearchParamsName[type.to_sym]
  end
  
  def profile_url
    current_user.merchant? ? merchant_path(current_user) : user_path(current_user)
  end

  def gen_ticket_share_url(ticket)
    share_url = "https://www.facebook.com/dialog/share?"
    share_url << "app_id=#{CGI.escape(Rails.application.secrets.facebook['api_key'].try(:to_s))}"
    share_url << "&display=popup"
    share_url << "&href=#{ticket_url(ticket)}"
    share_url << "&redirect_uri=#{ticket_url(ticket)}"
    share_url
  end

  def session_city
    session[:city] || 'Philadelphia'
  end

  def format_price price = 0
    number_to_currency(price, precision: 2, delimiter: "", format: "%n")
  end

  def scope_link(label, method, value)
    if params[method] == value.to_s or params[method].nil? && value == :all
      link_to label, params.merge(method => value, :page => 1), :class => :active
    else
      link_to label, params.merge(method => value, :page => 1)
    end
  end
end
