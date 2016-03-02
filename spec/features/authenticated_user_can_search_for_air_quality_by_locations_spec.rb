require 'rails_helper'

RSpec.feature "AuthenticatedUserCanSearchForAirQualityByLocations", type: :feature do
  before do
    @user = OmniAuth.config.mock_auth[:twitter]
  end

  it "can see air quality for their twitter account location" do
    visit root_path

    VCR.use_cassette("breezometer_service#air_quality") do
      click_on "Login with Twitter"
      expect(current_path).to eq(airquality_path)

      fill_in "Address", with: "Beijing, China"

      VCR.use_cassette("breezometer_service#air_quality_search") do
        click_on "Get Air Quality"

        expect(current_path).to eq(airquality_path)
        within('.air-quality-box') do
          expect(page).to have_content("Air Quality for Beijing")
          expect(page).to have_content("16")
          expect(page).to have_content("Poor Air Quality")
          expect(page).to have_content("Dominant Pollutant: Fine particulate matter (<2.5µm)")
        end
      end
    end
  end
end
