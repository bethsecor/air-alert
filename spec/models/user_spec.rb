require 'rails_helper'

RSpec.describe User, type: :model do
  it "should post a tweet" do
    user = create(:user)

    VCR.use_cassette("twitter#test_tweet") do
      message = user.tweet("Tweet!")
      expect(message.class).to eq Twitter::Tweet
    end
  end
end
