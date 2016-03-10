require 'rails_helper'

RSpec.feature "AuthenticatedUserCanSeeAirQualityForTwitterLocations", type: :feature do
  before do
    @user = OmniAuth.config.mock_auth[:twitter]
  end

  it "can see air quality for their twitter account location" do
    visit root_path

    VCR.use_cassette("breezometer_service#air_quality_denver") do
      click_on "Login with Twitter"
      expect(current_path).to eq(airquality_path)

      location = @user['info']['location']

      within('.air-quality-box') do
        expect(page).to have_content("Air Quality for #{location}")
        expect(page).to have_content("Air Quality")
        expect(page).to have_content("Dominant Pollutant:")
      end
    end
  end
end
