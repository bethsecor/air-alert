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
      expect(page).to have_content("AB 21")
      expect(page).to have_content("20152016")
      expect(page).to have_content("Medical marijuana: cultivation licenses.")
    end
  end

  it "should be show more detail for a bill" do
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

      VCR.use_cassette("sunlight_service#california_bill_greenhouse_gas") do
      click_on "Greenhouse Gas Reduction Fund: Transit and Intercity Rail Capital Program."

      expect(page).to have_content "Existing law requires all moneys, except " \
      "for fines and penalties, collected by the State Air Resources Board from " \
       "a market-based compliance mechanism relative to reduction of greenhouse gas " \
        " emissions to be deposited in the Greenhouse Gas Reduction Fund."
      end
    end
  end
end
