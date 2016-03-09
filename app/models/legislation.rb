class Legislation
  def self.service
    SunlightService.new
  end

  def self.bills(state)
    service.bills(state).map do |bill|
      build_object(bill)
    end
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end
end
