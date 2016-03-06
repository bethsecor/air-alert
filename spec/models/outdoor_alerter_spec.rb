require 'rails_helper'

RSpec.describe OutdoorAlerter, type: :model do
  it "should return the messages sent through twilio" do
    VCR.use_cassette("breezometer_service#air_quality_boston_for_alert") do
      outdoor_alerts = create_list(:outdoor_alert_all_levels, 3)
    end

    VCR.use_cassette("breezometer_service#air_quality_alerter") do
      alerts = OutdoorAlerter.alert
      expect(alerts.length).to eq 3
    end
  end
end
