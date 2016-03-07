require 'rails_helper'

RSpec.describe IndoorAlert, type: :model do
  it "can covert the string date to a datetime object" do
    indoor_alert = create(:indoor_alert)

    expect(indoor_alert.to_date).to eq Date.new(2016, 3, 7)
  end
end
