class BreezometerService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "http://api.breezometer.com/baqi") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def air_quality(location)
    Rails.cache.fetch("breezometer_air_#{location}", :expires => 15.minutes) do
      parse(connection.get("", {location: location, key: ENV["BREEZOMETER_KEY"]}))
    end
  end

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
