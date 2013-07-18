class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

  def require_login
    redirect_to '/' unless current_user
  end

  def current_user
    User.find_by_id(session[:user_id])
  end
end
