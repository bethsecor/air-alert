class Phone < ActiveRecord::Base
  has_many :outdoor_alerts
  before_validation :sanitize_phone

  validates :number, presence: true, length: { in: 10..11 }

  def sanitize_phone
    self.number = number.gsub(/[^0-9]/, '')
    self.number = "1" + number if number.length == 10
  end
end
