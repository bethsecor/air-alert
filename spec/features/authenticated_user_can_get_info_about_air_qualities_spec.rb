require 'rails_helper'

RSpec.feature "AuthenticatedUserCanGetInfoAboutAirQualities", type: :feature do
  it "should be able to click a link to get info about air quality" do
    visit root_path
    
    VCR.use_cassette("breezometer_service#air_quality_denver") do
      click_on "Login with Twitter"
    end

    click_on "Info"

    expect(current_path).to eq info_path

    expect(page).to have_link("Environmental Protection Agency")
    expect(page).to have_link("Ozone Aware")
  end
end
