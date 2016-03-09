require 'rails_helper'

RSpec.feature "AuthenticatedUserCanTweetAirQualities", type: :feature do
  before do
    @user = OmniAuth.config.mock_auth[:twitter]
  end

  it "can tweet the current air quality" do
    visit root_path

    VCR.use_cassette("breezometer_service#air_quality") do
      click_on "Login with Twitter"
      expect(current_path).to eq(airquality_path)

      VCR.use_cassette("twitter#tweet user location air quality message") do
        click_on "Tweet"

        expect(page).to have_content("Successfully tweeted!")
      end
    end
  end

  it "can tweet the current air quality from searched location" do
    visit root_path

    VCR.use_cassette("breezometer_service#air_quality") do
      click_on "Login with Twitter"
      visit airquality_path({air_quality_search: {address: "Beijing"}})

      VCR.use_cassette("twitter#tweet user location air quality message") do
        click_on "Tweet"

        expect(page).to have_content("Successfully tweeted!")
        expect(current_path).to eq(airquality_path)
      end
    end
  end
end
