require 'rails_helper'

RSpec.describe IndoorAlerter, type: :model do
  # include ActiveSupport::Testing::TimeHelpers
  it "will alert on day filter needs to be reminded" do
    VCR.use_cassette("twilio#indoor_alerts") do
      today = DateTime.now
      create(:indoor_alert, date: "#{today.month}/#{today.day}/#{today.year}")
      create(:indoor_alert, date: "#{today.month}/#{today.day}/#{today.year}")
      create(:indoor_alert, date: "03/16/2016")
    end

    VCR.use_cassette("twilio#indoor_alerter") do
      # travel_to DateTime.new(2016, 3, 7)
      alerts = IndoorAlerter.alert
      expect(alerts.length).to eq 2
      expect(IndoorAlert.all.length).to eq 1
    end
  end
end
