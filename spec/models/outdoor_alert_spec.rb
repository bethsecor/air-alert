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
end
