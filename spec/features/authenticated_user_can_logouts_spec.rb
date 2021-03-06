require 'rails_helper'

RSpec.feature "AuthenticatedUserCanLogouts", type: :feature do
  it "can logout an authenticated user" do
    visit root_path

    VCR.use_cassette("breezometer_service#air_quality") do
      click_on "Login with Twitter"

      expect(current_path).to eq(airquality_path)
      expect(page).to have_link('Logout')

      click_on 'Logout'
    end

    expect(current_path).to eq(root_path)

    visit airquality_path

    expect(current_path).to eq(root_path)
  end
end
