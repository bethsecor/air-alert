class SunlightService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "http://openstates.org/api/v1")
  end

  def bills(state)
    parse(connection.get("bills/", {q: "air+quality",
                                    state: state.downcase,
                                    status: "signed",
                                    last_action_since: "2015-01-01",
                                    apikey: ENV["SUNLIGHT_KEY"]}))
  end

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
