class MainController < ApplicationController

  def landing
    @user = User.find_by_id(session[:user_id])
  end
end