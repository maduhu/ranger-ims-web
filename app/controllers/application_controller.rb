class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_login
    logger.debug "require_login [enter]"
    redirect_to login_show_url and return unless session[:user].present?

    auth_response = HTTParty.get("#{RANGER_IMS_URI}/ping/", server_auth)

    logger.debug "auth: #{auth_response.inspect}"

    return true if auth_response.code.to_s == "200"

    flash[:alert] =
        case auth_response.code
          when 500
            "unknown error (server error)"
          when 400
            "unknown generic error"
          when 401
            "incorrect credentials"
        end

    session[:user] = nil
    session[:password] = nil
    redirect_to login_show_url
    false
  end

  def server_auth
    {:headers => {"User-Agent" => "Incidents333 IMS/0.7"}, :digest_auth=>{:username => session[:user], :password => session[:password]}}
  end
end
