class Incident < ActiveRecord::Base
  attr_accessible :etag, :servernum, :source

  def loaded?
    source.present?
  end

  def description
    logger.debug("parsed: #{parsed}")
    parsed["summary"]
  end

  def parsed
    @parsed ||= JSON.parse(source)
  end


  def source_update(new_source)
    source = new_source.to_json

    save!
  end

  def self.retrieve_by_server_num(server_num, server_auth)
    body, etag = retrieve(server_num, server_auth, :etag => true)
    Incident.new(:servernum => server_num, :etag => etag, :source => body)
  end

  def self.retrieve(server_num, server_auth, options = {})
    #TODO this is all screwed up etag-wise
    Rails.cache.fetch("#incident-#{server_num}-etag") do
      result = HTTParty.get("#{single_uri}#{server_num}", server_auth)
      if options.include? :etag
        [result.body, result.headers["etag"]]
      else
        result.body
      end
    end
  end


  def self.list(selection_params, server_auth)
    result = HTTParty.get(list_uri, server_auth)
    unmarshall_json_colllection(result.body, server_auth)
  end

  def self.unmarshall_json_colllection(json_coll, server_auth)
    objs = JSON.parse json_coll
    incidents = objs.collect{|element| Incident.new(:servernum => element[0], :etag =>element[1]) }

    # FIXME highly suboptimal querying here.
    incidents.each do |incident |
      logger.debug "incident servernum: #{incident.servernum} etag: #{incident.etag} source: #{incident.source || "not loaded" }"
      unless incident.loaded?
        incident.source = retrieve(incident.servernum, server_auth)
        logger.debug "[source load] incident servernum: #{incident.servernum} source: #{incident.source || "not loaded" }"
      end

    end

  end

  def self.list_uri
    "#{RANGER_IMS_URI}/#{name.pluralize.downcase}/"
  end

  def self.single_uri
    "#{RANGER_IMS_URI}/#{name.pluralize.downcase}/"
  end

  def save!



  end
end
