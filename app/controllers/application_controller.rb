class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  has_mobile_fu
  before_action :force_tablet_html
  before_action :set_request_format

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end

  helper_method :get_session_city

  protected

  def get_session_city
    session[:city] || 'Philadelphia'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :role]
  end

  def force_tablet_html
    session[:tablet_view] = false
  end

  def set_request_format
    request.format = :mobile if is_mobile_device?
  end
end
