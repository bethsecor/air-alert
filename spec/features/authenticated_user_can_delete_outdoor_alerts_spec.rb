require 'rails_helper'

RSpec.feature "AuthenticatedUserCanDeleteOutdoorAlerts", type: :feature do
  # before do
  #   @user = OmniAuth.config.mock_auth[:twitter]
  # end

  it "can sign up for outdoor air quality alerts" do
    VCR.use_cassette("breezometer_service#air_quality_boston") do
      @user = create(:user_with_outdoor_alert)
    end
    ApplicationController.any_instance.stubs(:current_user).returns(@user)

    visit alerts_path

    alert_id = @user.outdoor_alerts.first.id

    within("#outdoor-air-alert-#{alert_id}") do
      click_on "Delete"
    end

    expect(current_path).to eq alerts_path

    # expect(page).to_not have_css("#outdoor-air-alert-#{alert_id}")
    expect(@user.reload.outdoor_alerts.count).to eq 0
  end
end
