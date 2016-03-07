class IndoorAlert < ActiveRecord::Base
  belongs_to :phone
  belongs_to :user

  before_save :to_date

  validates :phone_id, presence: {:message => "number you entered needs checking!"}
  validates :name, presence: true
  validates :date, presence: true

  def initial_alert
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    welcome = "Welcome to Air Alerts! You will receive a reminder to replace the filter" \
              " for #{self.name} on #{self.date}."
    message = @client.account.messages.create(
      :from => ENV['TWILIO_NUMBER'],
      :to => "+#{self.phone.number}",
      :body => welcome
    )
    message.body
  end

  def to_date
    month, day, year = self.date.split("/").map(&:to_i)
    self.reminder = Date.new(year, month, day)
  end
end
