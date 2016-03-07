require 'rails_helper'

RSpec.describe IndoorAlerter, type: :model do
  include ActiveSupport::Testing::TimeHelpers
  it "will alert on day filter needs to be reminded" do
    VCR.use_cassette("twilio#indoor_alerts") do
      create(:indoor_alert, date: "03/06/2016")
      create(:indoor_alert, date: "03/06/2016")
      create(:indoor_alert, date: "03/16/2016")
    end

    VCR.use_cassette("twilio#indoor_alerter") do
      travel_to DateTime.new(2016, 3, 6)
      alerts = IndoorAlerter.alert
      expect(alerts.length).to eq 2
      expect(IndoorAlert.all.length).to eq 1
    end
  end
end
