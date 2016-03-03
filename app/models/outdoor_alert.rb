class OutdoorAlert < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  belongs_to :phone

  validates :user_id, presence: true
  validates :location_id, presence: {:message => " you entered needs checking!"}
  validates :phone_id, presence: {:message => "number you entered needs checking!"}
  validates :reason, presence: true
  validates :poor, presence: true
  validates :low, presence: true
  validates :moderate, presence: true
  validates :fair, presence: true
  validates :excellent, presence: true

  def initial_alert
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    welcome = "Welcome to Air Alerts! You will receive air quality updates for #{self.location.address}."
    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => "+#{self.phone.number}",
      :body => welcome
    )
    # puts message.to
  end
end
