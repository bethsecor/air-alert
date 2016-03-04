require 'rails_helper'

RSpec.feature "AuthenticatedUserCanDeleteOutdoorAlerts", type: :feature do
  it "can delete an outdoor air quality alerts" do
    VCR.use_cassette("breezometer_service#air_quality_boston") do
      @user = create(:user_with_outdoor_alert)
    end
    ApplicationController.any_instance.stubs(:current_user).returns(@user)

    visit alerts_path

    alert = @user.outdoor_alerts.first
    location = alert.location
    phone = alert.phone

    within("#outdoor-air-alert-#{alert.id}") do
      click_on "Delete"
    end

    expect(current_path).to eq alerts_path

    expect(@user.reload.outdoor_alerts.count).to eq 0
    expect(Location.all.count).to eq 0
    expect(Phone.all.count).to eq 0
  end
end
