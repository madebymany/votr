class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate!
    unless current_user
      store_previous_url!
      redirect_to "/auth/twitter"
    end
  end

  def authenticate_admin!
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == ENV["AUTH_PASSWORD"]
    end
  end

  def not_found
    render "404"
  end

  def voting_open?
    Time.current > Vote::OPENS
  end

  def voting_closed?
    Time.current > Vote::CLOSES
  end

  helper_method :voting_open?
  helper_method :voting_closed?

private

  def store_previous_url!
    session[:return_to] = request.referer
  end

  def next_url
    session[:return_to].present? ? session.delete(:return_to) : root_url
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

end
