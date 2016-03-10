require 'rails_helper'

RSpec.describe IndoorAlerter, type: :model do
  it "will alert on day filter needs to be reminded" do
    VCR.use_cassette("twilio#indoor_alerts") do
      today = DateTime.now
      create(:indoor_alert, date: "#{today.month}/#{today.day}/#{today.year}")
      create(:indoor_alert, date: "#{today.month}/#{today.day}/#{today.year}")
      create(:indoor_alert, date: "03/16/2016")
    end

    VCR.use_cassette("twilio#indoor_alerter") do
      alerts = IndoorAlerter.alert
      expect(alerts.length).to eq 2
      expect(alerts.first).to eq "Sent from your Twilio trial account - Air Alert: Time to change the filter for Furnace!"
      expect(IndoorAlert.all.length).to eq 1
    end
  end
end
