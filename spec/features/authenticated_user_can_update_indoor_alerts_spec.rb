require 'rails_helper'

RSpec.feature "AuthenticatedUserCanUpdateIndoorAlerts", type: :feature do
  it "can update an indoor filter reminder" do
    VCR.use_cassette("twilio#indoor_welcome") do
      @user = create(:user_with_indoor_alert)
    end
    ApplicationController.any_instance.stubs(:current_user).returns(@user)

    visit alerts_path

    alert = @user.indoor_alerts.first
    phone = alert.phone

    within("#indoor-air-alert-#{alert.id}") do
      click_on "Update"
    end

    expect(current_path).to eq edit_indoor_alert_path(id: alert.id)

    fill_in "Air Filter Name", with: "HEPA filter"
    fill_in "Remind me on:", with: "3/10/2016"
    fill_in "Phone Number", with: ENV['VALID_PHONE']
    click_on "Remind Me!"

    expect(current_path).to eq alerts_path

    alert = IndoorAlert.last.reload

    expect(alert.name).to eq "HEPA filter"
  end

  it "cannot update an indoor filter reminder without a name" do
    VCR.use_cassette("twilio#indoor_welcome") do
      @user = create(:user_with_indoor_alert)
    end
    ApplicationController.any_instance.stubs(:current_user).returns(@user)

    visit alerts_path

    alert = @user.indoor_alerts.first
    phone = alert.phone

    within("#indoor-air-alert-#{alert.id}") do
      click_on "Update"
    end

    expect(current_path).to eq edit_indoor_alert_path(id: alert.id)

    fill_in "Air Filter Name", with: ""
    fill_in "Remind me on:", with: "3/10/2016"
    fill_in "Phone Number", with: ENV['VALID_PHONE']
    click_on "Remind Me!"

    expect(page).to have_content "Name can't be blank"
  end
end
