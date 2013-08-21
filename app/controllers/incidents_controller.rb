class IncidentsController < ApplicationController
  # GET /incidents
  # GET /incidents.json
  def index

  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
    incident, @etag = Incident.retrieve(params[:id], server_auth)
    @incident = JSON.parse(incident).with_indifferent_access
    logger.debug "incident record #{@incident}"

  end

  # GET /incidents/new
  # GET /incidents/new.json
  def new
    @incident = Incident.new
  end

  # GET /incidents/1/edit
  def edit
    @incident = Incident.retrieve(params[:id], server_auth)
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(params[:incident])
    # probably will necessitate substantial json hacking around
  end

  # PUT /incidents/1
  # PUT /incidents/1.json
  def update
    @incident = Incident.retrieve(params[:id], server_auth)
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    render :text => "not deletable by policy", :status => :bad_request
  end
end
