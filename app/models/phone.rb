class Phone < ActiveRecord::Base
  has_many :outdoor_alerts
  before_create :sanitize_phone

  def sanitize_phone
    self.number = number.gsub(/[^0-9]/, '')
    self.number = "1" + number if number.length == 10
  end
end
