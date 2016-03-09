class Bill
  def self.service
    SunlightService.new
  end

  def self.bill(bill_id)
    build_object(service.bill(bill_id))
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end
end
