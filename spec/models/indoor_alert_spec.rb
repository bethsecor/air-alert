require 'rails_helper'

RSpec.describe IndoorAlert, type: :model do
  it "can covert the string date to a datetime object" do
    indoor_alert = create(:indoor_alert)

    expect(indoor_alert.to_date).to eq Date.new(2016, 3, 7)
  end

  it "sends a welcome text" do
    indoor_alert = create(:indoor_alert)

    VCR.use_cassette("twilio#indoor_alert_initial_text") do
      message = indoor_alert.initial_alert

      expect(message).to eq "Sent from your Twilio trial account - Welcome to Air Alerts! You will receive a reminder to replace the filter" \
                            " for #{indoor_alert.name} on #{indoor_alert.date}."
    end
  end

  it "cannot be saved without a name" do
    phone = create(:phone)
    indoor_alert = IndoorAlert.new(phone_id: phone.id,
                                   name: "",
                                   date: "03/11/2016")

    refute(indoor_alert.valid?)
  end

  it "cannot be saved without a date" do
    phone = create(:phone)
    indoor_alert = IndoorAlert.new(phone_id: phone.id,
                                   name: "HEPA filter",
                                   date: "")

    refute(indoor_alert.valid?)
  end

  it "cannot be saved without a phone" do
    phone = create(:phone)
    indoor_alert = IndoorAlert.new(phone_id: nil,
                                   name: "HEPA filter",
                                   date: "03/11/2016")

    refute(indoor_alert.valid?)
  end
end
