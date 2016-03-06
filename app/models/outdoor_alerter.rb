class OutdoorAlerter
  def self.alert
    all_twilio_messages = Location.all.map do |location|
      air_quality = AirQuality.air_quality(location.address)
      unless air_quality.errors
        alert_people_for(location, air_quality)
      end
    end
    all_twilio_messages.flatten
  end

  def self.alert_people_for(location, air_quality)
    quality = air_quality.breezometer_description.split(" ").first.downcase
    twilio_messages = location.outdoor_alerts.specific(quality).map do |alert|
      twilio(alert, location, air_quality)
    end
  end

  def self.twilio(alert, location, air_quality)
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    message = @client.account.messages.create(
      :from => ENV['TWILIO_NUMBER'],
      :to => "+#{alert.phone.number}",
      :body => "Air Alert: Air quality for #{location.address} is" \
                " #{air_quality.breezometer_aqi}" \
                " (#{air_quality.breezometer_description})." \
                " #{air_quality.random_recommendations[alert.breezometer_reason]}"
    )
    message.body
  end
end
