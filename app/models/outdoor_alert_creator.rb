class OutdoorAlertCreator
  def self.make(location_params, phone_params, outdoor_alert_params, current_user)
    location = Location.find_or_create_by(location_params)
    phone = Phone.find_or_create_by(phone_params)

    outdoor_alert = OutdoorAlert.new(outdoor_alert_params)
    outdoor_alert.user = current_user
    outdoor_alert.location = location
    outdoor_alert.phone = phone

    [location, phone, outdoor_alert]
  end

  def self.update(id, location_params, phone_params, outdoor_alert_params)
    location = Location.find_or_create_by(location_params)
    phone = Phone.find_or_create_by(phone_params)

    outdoor_alert = OutdoorAlert.update(id, outdoor_alert_params)
    outdoor_alert.location = location
    outdoor_alert.phone = phone

    [location, phone, outdoor_alert]
  end
end
