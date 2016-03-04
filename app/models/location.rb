class Location < ActiveRecord::Base
  has_many :outdoor_alerts

  validates :address, presence: true
  validate :address_must_be_supported_by_breezometer

  def address_must_be_supported_by_breezometer
    breezometer_service_errors = AirQuality.air_quality(self.address).error
    if breezometer_service_errors
      errors.add(:address, "Location not supported, please try another location.")
    end
  end
end
