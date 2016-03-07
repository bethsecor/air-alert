require 'rails_helper'

RSpec.feature "AuthenticatedUserCanDeleteAnIndoorAlerts", type: :feature do
  it "can delete an indoor alert reminder" do
    @user = create(:user_with_indoor_alert)
    ApplicationController.any_instance.stubs(:current_user).returns(@user)

    visit alerts_path

    alert = @user.indoor_alerts.first
    phone = alert.phone

    within("#indoor-air-alert-#{alert.id}") do
      click_on "Delete"
    end

    expect(current_path).to eq alerts_path

    expect(@user.reload.indoor_alerts.count).to eq 0
    expect(Phone.all.count).to eq 0
  end
end
