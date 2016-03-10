require 'rails_helper'

RSpec.feature "AuthenticatedUserCanUpdateOutdoorAlerts", type: :feature do
  it "can update an outdoor air quality alerts" do
    VCR.use_cassette("breezometer_service#air_quality_boston") do
      @user = create(:user_with_outdoor_alert)
    end
    ApplicationController.any_instance.stubs(:current_user).returns(@user)

    visit alerts_path

    alert = @user.outdoor_alerts.first
    location = alert.location
    phone = alert.phone

    within("#outdoor-air-alert-#{alert.id}") do
      click_on "Update"
    end

    expect(current_path).to eq edit_outdoor_alert_path(id: alert.id)

    fill_in "Address", with: "Denver, CO"
    fill_in "Number", with: ENV['VALID_PHONE']
    choose "Health"
    check "Low Air Quality"

    VCR.use_cassette("breezometer_service#air_quality_check_update") do
      click_on "Alert Me!"
    end

    expect(current_path).to eq alerts_path

    alert = OutdoorAlert.last.reload

    expect(alert.location.address).to eq "Denver, CO"
  end

  it "cannot update an outdoor air quality alerts with invalid phone" do
    VCR.use_cassette("breezometer_service#air_quality_boston") do
      @user = create(:user_with_outdoor_alert)
    end
    ApplicationController.any_instance.stubs(:current_user).returns(@user)

    visit alerts_path

    alert = @user.outdoor_alerts.first
    location = alert.location
    phone = alert.phone

    within("#outdoor-air-alert-#{alert.id}") do
      click_on "Update"
    end

    expect(current_path).to eq edit_outdoor_alert_path(id: alert.id)

    fill_in "Address", with: "Denver, CO"
    fill_in "Number", with: "303"
    choose "Health"
    check "Low Air Quality"

    VCR.use_cassette("breezometer_service#air_quality_check_update") do
      click_on "Alert Me!"
    end

    expect(page).to have_content "Phone number you entered needs checking!"
  end
end
