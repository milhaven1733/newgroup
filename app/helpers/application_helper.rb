module ApplicationHelper
  def render_date(datetime)
    datetime.to_s(:db)
  end

  def liked?(ticket)
    current_user.present? && !current_user.votes.where(votable_id: ticket.id).blank?
  end
  
  def show_shipping_fee(order)
    order.shipping_fee_included? ? order.shipping_to_currency : "Will Call"
  end
  
  def category_options
    Category.all.map{ |category| [category.name, category.id]}.uniq
  end
  
  def q_param_name(type)
    HomeController::SearchParamsName[type.to_sym]
  end
  
  def saved_selected_item(type)
    @search_conditions[q_param_name(type)] if @search_conditions
  end

  def profile_url
    current_user.merchant? ? merchant_path(current_user) : user_path(current_user)
  end

  def format_datetime(datetime)
    datetime.try(:strftime, '%I:%M %p')
  end

  def gen_ticket_share_url(ticket)
    share_url = "https://www.facebook.com/dialog/share?"
    share_url << "app_id=#{CGI.escape(Rails.application.secrets.facebook["api_key"].try(:to_s))}"
    share_url << "&display=popup"
    share_url << "&href=#{ticket_url(ticket)}"
    share_url << "&redirect_uri=#{ticket_url(ticket)}"
    share_url
  end
end
