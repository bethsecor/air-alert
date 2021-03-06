FactoryGirl.define do
  factory :user do
    provider 'twitter'
    uid '12345'
    name 'Miss Capybara'
    nickname 'miss.capybara'
    location 'Denver, CO'
    token ENV['TWITTER_TOKEN']
    secret ENV['TWITTER_SECRET_TOKEN']

    factory :user_with_outdoor_alert do
      transient do
        outdoor_alert_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:outdoor_alert, evaluator.outdoor_alert_count, user: user)
      end
    end

    factory :user_with_indoor_alert do
      transient do
        indoor_alert_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:indoor_alert, evaluator.indoor_alert_count, user: user)
      end
    end
  end

  factory :outdoor_alert do
    user
    location
    phone
    sequence(:reason, %w(general health children athlete).cycle) { |type| "type"}
    excellent 0
    fair 0
    moderate 0
    low [0,1].sample
    poor 1

    factory :outdoor_alert_all_levels do
      excellent 1
      fair 1
      moderate 1
      low 1
      poor 1
    end
  end

  factory :indoor_alert do
    user
    phone
    name "Furnace"
    date "3/7/2016"
  end

  factory :location do
    address "Boston, MA"
  end

  factory :phone do
    number "1#{ENV['VALID_PHONE']}"
  end
end
