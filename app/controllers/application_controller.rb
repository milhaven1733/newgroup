class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :force_tablet_html
  has_mobile_fu

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_request_format

  protected

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
