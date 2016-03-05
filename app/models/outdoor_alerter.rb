class OutdoorAlerter
  def self.alert
    Location.all.each do |location|
      binding.pry
      air_quality = AirQuality.air_quality(location.address)
      unless air_quality.errors
        binding.pry
        quality = air_quality.breezometer_description.split(" ").first.downcase
        location.outdoor_alerts.where("outdoor_alerts.#{quality} = ?", 1).each do |alert|
          @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
          message = @client.account.messages.create(
            :from => ENV['TWILIO_NUMBER'],
            :to => "+#{alert.phone.number}",
            :body => "Air Alert: Air quality for #{location} is #{air_quality.breezometer_aqi}" \
                      "(#{quality}). #{air_quality.random_recommendations[alert.reason]}"
          )
        end
      end
    end
  end
end
