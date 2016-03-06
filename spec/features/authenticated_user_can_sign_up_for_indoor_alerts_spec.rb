require 'rails_helper'

RSpec.feature "AuthenticatedUserCanSignUpForIndoorAlerts", type: :feature do
  it "a user can sign up for an air filter replacement reminder" do
    visit root_path

    VCR.use_cassette("breezometer_service#air_quality") do
      click_on "Login with Twitter"

      click_on "Manage Alerts"
    end

    expect(current_path).to eq alerts_path

    click_on "Create Air Filter Replacement Reminder"
    expect(current_path).to eq new_indoor_alert_path

    fill_in "Air Filter Name", with: "Furnace"
    fill_in "Remind me on:", with: "3/10/2016"
    fill_in "Phone Number", with: ENV['VALID_PHONE']

    VCR.use_cassette("twilio#indoor_welcome") do
      click_on "Remind Me!"
    end

    expect(current_path).to eq alerts_path

    alert = IndoorAlert.last

    within("#indoor-air-alert-#{alert.id}") do
      expect(page).to have_content(alert.name)
      expect(page).to have_content(alert.date)
      expect(page).to have_content(alert.phone.number)
    end
  end
end
