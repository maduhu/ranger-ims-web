class LoginController < ApplicationController

  def logout
    session[:user] = nil
    session[:password] = nil
    redirect_to root_url
  end

  def show
    logger.debug "logger#show [enter]"
  end

  def do
    logger.debug "logger#do [enter]"
    redirect_to login_show_url unless params[:user] and params[:pass]

    session[:user] = params[:user]
    session[:password] = params[:pass]

    redirect_to root_url
  end
end
