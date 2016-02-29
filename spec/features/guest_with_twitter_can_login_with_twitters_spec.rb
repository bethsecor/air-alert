require 'rails_helper'

RSpec.feature "GuestWithTwitterCanLoginWithTwitters", type: :feature do
  it "can authorize a user with their twitter account" do
    visit root_path

    click_on "Login with Twitter"

    expect(current_path).to eq(airquality_path)
  end
end
