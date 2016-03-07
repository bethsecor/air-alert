namespace :air do
  desc "Alert all the peoples."
  task :alerts => :environment do
    Rails.cache.clear
    OutdoorAlerter.alert
    IndoorAlerter.alert
  end
end
