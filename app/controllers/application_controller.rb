class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  after_action :request_response
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  def logged_in?
    !!current_user
  end
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end

  private
  def request_response
    Response.create(
      remote_ip: request.remote_ip,
      request_method: request.method,
      request_url: request.url,
      response_status: response.status,
      response_content_type: response.content_type
    )

  end

end
