class AirQuality
  def self.service
    BreezometerService.new
  end

  def self.air_quality(location)
    build_object(service.air_quality(location.gsub(" ", "+")))
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end
end
