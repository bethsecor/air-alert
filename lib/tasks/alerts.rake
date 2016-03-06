namespace :air do
  desc "Alert all the peoples."
  task :alerts => :environment do
    OutdoorAlerter.alert
  end
end
