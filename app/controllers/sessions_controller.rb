class SessionsController < ApplicationController

  def sign_in
    redirect_to request_token.authorize_url
  end

  def sign_out
    session.clear
    redirect_to '/'
  end

  def auth
    @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    session.delete(:request_token)
    @user = User.find_by_oauth_token(params[:oauth_token])

    if @user
      @user.update_attributes(oauth_token: @access_token.token, oauth_secret: @access_token.secret)
    else
      @user = User.create(id: @access_token.params[:user_id], oauth_token: @access_token.token, oauth_secret: @access_token.secret)
    end

    session[:user_id] = @user.id

    redirect_to '/'
  end

  private

  def oauth_consumer
    raise RuntimeError, "You must set TWITTER_KEY and TWITTER_SECRET in your server environment." unless ENV['TWITTER_KEY'] and ENV['TWITTER_SECRET']
    @consumer ||= OAuth::Consumer.new(
      ENV['TWITTER_KEY'],
      ENV['TWITTER_SECRET'],
      :site => "https://api.twitter.com"
    )
  end

  def request_token
    if not session[:request_token]
      host_and_port = request.host
      host_and_port << ":3000" if request.host == "localhost" || request.host == "0.0.0.0"
      session[:request_token] = oauth_consumer.get_request_token(
        :oauth_callback => "http://#{host_and_port}/session/auth"
      )
    end
    session[:request_token]
  end

end