module IncidentsHelper

  def display_priority(incident)
    incident.parsed["priority"] || "new"
  end

  def display_incident_types(incident)
    types = incident.parsed["incident_types"]

    return "-" if types.blank?

    types.join ", "
  end

  def display_rangers(incident)
    callsigns = incident.parsed["ranger_handles"]

    return "" if callsigns.blank?

    callsigns.join ", "
  end

  def display_location(incident)
    name = incident.parsed["location_name"]
    loc = incident.parsed["location_address"]

    return "#{name}<br/><small>#{loc}</small>" if name.present? && loc.present?
    name || loc || "-"
  end

  def display_dt(incident,which)
    time_s = incident.parsed[which.to_s]

    return "" if time_s.blank?

    dt = DateTime.parse(time_s)

    dt.strftime("%^a %H:%M")
  end

end
