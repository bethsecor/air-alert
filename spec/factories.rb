FactoryGirl.define do
  factory :user do
    provider 'twitter'
    uid '12345'
    name 'Miss Capybara'
    nickname 'miss.capybara'
    location 'Denver, CO'
    token ENV['TWITTER_TOKEN']
    secret ENV['TWITTER_SECRET_TOKEN']
  end
end
