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

      fill_in "Location", with: "Beijing, China"

      VCR.use_cassette("breezometer_service#air_quality_search") do
        click_on "Get Air Quality"

        expect(current_path).to eq(airquality_path)
        within('.air-quality-box') do
          expect(page).to have_content("Air Quality for Beijing")
          expect(page).to have_content("30")
          expect(page).to have_content("Low Air Quality")
          expect(page).to have_content("Dominant Pollutant: Inhalable particulate matter (<10µm)")
        end
      end
    end
  end
end
