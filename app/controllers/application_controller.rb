class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_login
    logger.debug "require_login [enter]"
    redirect_to login_show_url and return unless session[:user].present?

    auth_response = HTTParty.get("#{RANGER_IMS_URI}/ping", :digest_auth=>{:username => session[:user], :password => session[:password]})

    return true if auth_response.code.to_s == "200"


    session[:user] = nil
    session[:pass] = nil
    redirect_to login_show_url
    false
  end
end
