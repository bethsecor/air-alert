class SunlightService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "http://openstates.org/api/v1")
  end

  def bills(state)
    Rails.cache.fetch("sunlight_all_bills_#{state}", expires_in: 24.hours) do
      parse(connection.get("bills/", {q: "air+quality",
                                      state: state.downcase,
                                      status: "signed",
                                      last_action_since: "2015-01-01",
                                      apikey: ENV["SUNLIGHT_KEY"]}))
    end
  end

  def bill(bill_id)
    Rails.cache.fetch("sunlight_bill_#{bill_id}", expires_in: 24.hours) do
      parse(connection.get("bills/#{bill_id}/", { apikey: ENV["SUNLIGHT_KEY"] }))
    end
  end

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
