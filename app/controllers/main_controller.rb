class MainController < ApplicationController
  skip_before_filter :require_login

  def landing
    @user = User.find_by_id(session[:user_id])
  end
end