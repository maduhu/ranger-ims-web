class Incident < ActiveRecord::Base
  attr_accessible :etag, :servernum, :source


  def parsed
    @parsed ||= JSON.parse(source)
  end


  def source_update(new_source)
    source = new_source.to_json

    save!
  end

  def self list_uri
    "#{RANGER_IMS_URI}/#{name.pluralize.downcase}"
  end

  def self single_uri
    "#{RANGER_IMS_URL}/#{name.downcase}"
  end

  def save!



  end
end
