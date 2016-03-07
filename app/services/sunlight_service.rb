class SunlightService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "http://openstates.org/api/v1") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def bills(state)
    parse(connection.get("bills", {q: "air+quality", state: state, apikey: ENV["SUNLIGHT_KEY"]}))
  end

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
