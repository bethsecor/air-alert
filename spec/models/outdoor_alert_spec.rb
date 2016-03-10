require 'rails_helper'

RSpec.describe OutdoorAlert, type: :model do
  it "should return symbol for breezometer reason endpoint" do
    VCR.use_cassette("breezometer_service#air_quality_boston_for_reason") do
      outdoor_alert_children = create(:outdoor_alert, reason: "children")

      expect(outdoor_alert_children.breezometer_reason).to eq :children
    end

    VCR.use_cassette("breezometer_service#air_quality_boston_for_reason") do
      outdoor_alert_health = create(:outdoor_alert, reason: "health")

      expect(outdoor_alert_health.breezometer_reason).to eq :health
    end

    VCR.use_cassette("breezometer_service#air_quality_boston_for_reason") do
      outdoor_alert_athlete = create(:outdoor_alert, reason: "athlete")

      expect(outdoor_alert_athlete.breezometer_reason).to eq :sport
    end

    VCR.use_cassette("breezometer_service#air_quality_boston_for_reason") do
      outdoor_alert_general = create(:outdoor_alert, reason: "general")

      expect(outdoor_alert_general.breezometer_reason).to eq :outside
    end
  end

  it "should send text with a welcome message" do
    outdoor_alert = create(:outdoor_alert)

    VCR.use_cassette("twilio#outdoor_alert_initial_alert") do
      message = outdoor_alert.initial_alert

      expect(message).to eq "Sent from your Twilio trial account - " \
      "Welcome to Air Alerts! You will receive air quality updates for #{outdoor_alert.location.address}."
    end
  end

  it "cannot be saved without a location" do
    user = create(:user)
    phone = create(:phone)
    outdoor_alert = OutdoorAlert.new(user_id: user.id,
                                     location_id: nil,
                                     phone_id: phone.id,
                                     reason: "general",
                                     poor: 1)

    refute(outdoor_alert.valid?)
  end

  it "cannot be saved without a phone" do
    user = create(:user)
    location = create(:location)
    outdoor_alert = OutdoorAlert.new(user_id: user.id,
                                     location_id: location.id,
                                     phone_id: nil,
                                     reason: "general",
                                     poor: 1)

    refute(outdoor_alert.valid?)
  end

  it "cannot be saved without a reason" do
    user = create(:user)
    phone = create(:phone)
    location = create(:location)
    outdoor_alert = OutdoorAlert.new(user_id: user.id,
                                     location_id: location.id,
                                     phone_id: phone.id,
                                     reason: "",
                                     poor: 1)

    refute(outdoor_alert.valid?)
  end
end
