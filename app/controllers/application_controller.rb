class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from JSON::ParserError, with: :resource_not_found
  layout :layout_by_resource
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authorize!
    redirect_to root_path unless current_user
  end

  protected

  def layout_by_resource
    if params["controller"] == "welcome"
      "welcome"
    else
      "application"
    end
  end

  def resource_not_found
    flash[:alert] = 'Oops! Something went wrong!'
    redirect_to airquality_path
  end
end
