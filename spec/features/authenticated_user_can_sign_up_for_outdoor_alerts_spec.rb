require 'rails_helper'

RSpec.feature "AuthenticatedUserCanSignUpForOutdoorAlerts", type: :feature do
  before do
    @user = OmniAuth.config.mock_auth[:twitter]
  end

  it "can sign up for outdoor air quality alerts" do
    visit root_path

    VCR.use_cassette("breezometer_service#air_quality") do
      click_on "Login with Twitter"

      click_on "Manage Alerts"
    end

    expect(current_path).to eq alerts_path

    click_on "Create Outdoor Air Quality Alert"
    expect(current_path).to eq new_outdoor_alert_path

    fill_in "Location", with: "Los Angeles"
    fill_in "Phone", with: "303-931-5611"
    choose "Health"
    check "Low Air Quality"
    click_on "Alert Me!"

    expect(current_path).to eq alerts_path

    alert = OutdoorAlert.last

    within("#air-alert-#{alert.id}") do
      expect(page).to have_content(alert.address.location)
      expect(page).to have_content(alert.phone.number)
      expect(page).to have_content(alert.reason)
      within("low-#{alert.id}") do
        expect(page).to have_content("x")
      end
    end

  end
end
