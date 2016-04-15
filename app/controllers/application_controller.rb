class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to new_session_url, alert: 'Please sign in first'
    end
  end

  def current_user
    assign_user if @current_user.nil?
    @current_user
  end
  helper_method :current_user

  def assign_user
    @current_user = current_employer || current_worker
  end

  def current_employer
    @current_employer ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_worker
    @current_worker ||= Worker.find(session[:worker_id]) if session[:worker_id]
  end
  helper_method :current_worker

  def current_user?(user)
    current_user == user
  end
  helper_method :current_user?

  def current_worker?(worker)
    current_worker == worker
  end
  helper_method :current_worker?
end
