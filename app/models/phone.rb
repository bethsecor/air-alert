class Phone < ActiveRecord::Base
  has_many :outdoor_alerts
  before_validation :sanitize_phone

  validates :number, presence: true, length: { in: 10..12 }
  validate :proper_phone_number

  def sanitize_phone
    self.number = number.gsub(/[^0-9]/, '')
    self.number = "1" + number if number.length == 10
  end

  def proper_phone_number
    binding.pry
    unless self.valid_number?
      errors.add(:phone, "number is not a valid, please try another number.")
    end
  end

  def valid_number?
    lookup_client = Twilio::REST::LookupsClient.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    begin
      response = lookup_client.phone_numbers.get("+#{self.number}")
      response.phone_number
      return true
    rescue => e
      if e.code == 20404
        return false
      else
        raise e
      end
    end
  end
end
