require 'rails_helper'

RSpec.feature "AuthenticatedUserCanSeeCurrentAirQualityLegislations", type: :feature do
  it "should be able to see current bills related to air quality" do
    visit root_path

    VCR.use_cassette("breezometer_service#air_quality") do
      click_on "Login with Twitter"

      expect(current_path).to eq(airquality_path)
      click_on "Legislation"
    end

    expect(current_path).to eq legislation_path

    select "California"
    VCR.use_cassette("sunlight_service#california_bills") do
      click_on "Find those bills"

      expect(page).to have_content("California Legislation:")
    end
  end
end
