class IndoorAlertCreator
  def self.make(phone_params, indoor_alert_params, current_user)
    phone = Phone.find_or_create_by(phone_params)

    indoor_alert = IndoorAlert.new(indoor_alert_params)
    indoor_alert.user = current_user
    indoor_alert.phone = phone

    [phone, indoor_alert]
  end
end
