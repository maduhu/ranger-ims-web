module IncidentsHelper

  def display_name(incident)
    incident[:summary] || incident[:report_entries].first.andand[:test] || "no summary for this incident"
  end

  def display_status(incident)
    case
      when incident[:closed]
        "Closed"
      when incident[:on_scene]
        "On Scene"
      when incident[:dispatched]
        "Dispatched"
      when incident[:created]
        "Open for #{display_time_distance(incident, :created)}"
    end
  end


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

  def display_location_show(incident)
    name = incident[:location_name]
    loc = incident[:location_address]

    if name.present? && loc.present?
      "#{name} (#{loc})"
    elsif name.present?
      name
    elsif loc.present?
      loc
    else
      "(location unset)"
    end

  end

  def display_location(incident)
    name = incident.parsed["location_name"]
    loc = incident.parsed["location_address"]

    return "#{name}<br/><small>#{loc}</small>" if name.present? && loc.present?
    name || loc || "-"
  end

  def display_time_distance(incident, which)
    time_s = incident[which]
    return "" if time_s.blank?
    dt = DateTime.parse(time_s)
    distance_of_time_in_words_to_now(dt)
  end

  def display_dt2(incident,which)
    time_s = incident[which]

    return "-" if time_s.blank?

    dt = DateTime.parse(time_s)

    dt.strftime("%^a %H:%M")
  end


  def display_dt(incident,which)
    time_s = incident.parsed[which.to_s]

    return "" if time_s.blank?

    dt = DateTime.parse(time_s)

    dt.strftime("%^a %H:%M")
  end

end
