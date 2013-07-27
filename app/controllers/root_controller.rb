class RootController < ApplicationController


  before_filter :require_login
  def index


    @incidents = Incident.list({}, server_auth)
  end
end
