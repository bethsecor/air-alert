class BreezometerService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "http://api.breezometer.com/baqi") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def air_quality(location)
    parse(connection.get("", {location: location, key: ENV["BREEZOMETER_KEY"]}))
  end

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
