class IndoorAlerter
  def self.alert
    alerts = IndoorAlert.where('reminder = ?', DateTime.now.to_date)
    alerts.map do |alert|
      message = twilio(alert)
      alert.delete
      message
    end
  end

  def self.twilio(alert)
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    message = @client.account.messages.create(
      :from => ENV['TWILIO_NUMBER'],
      :to => "+#{alert.phone.number}",
      :body => "Air Alert: Time to change the filter for #{alert.name}!"
    )
    message.body
  end
end
