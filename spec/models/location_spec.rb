require 'rails_helper'

RSpec.describe Location, type: :model do
  it "should check the location through breezometer before saving to db" do
    VCR.use_cassette("breezometer_service#create_location_boston") do
      location = Location.new(address: "Boston, MA")
      expect(location.valid?)
    end
  end

  it "not valid if breezometer doesn't support location, return error" do
    VCR.use_cassette("breezometer_service#unsupported_location") do
      location = Location.new(address: "Mumbai")
      refute(location.valid?)
    end
  end

  it "not valid if location not provided" do
    VCR.use_cassette("breezometer_service#no_location") do
      location = Location.new(address: "")
      refute(location.valid?)
    end
  end
end
