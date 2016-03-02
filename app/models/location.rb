class Location < ActiveRecord::Base
  has_many :outdoor_alerts
end
