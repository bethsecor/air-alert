require 'rails_helper'

RSpec.describe Phone, type: :model do
  it "takes out non-number characters ans adds US country code if not provided" do
    phone = Phone.create(number: "(999) 999-9999")

    expect(phone.number).to eq "19999999999"
  end

  it "cannot be saved without a number" do
    phone = Phone.new(number: "")

    refute(phone.valid?)
  end

  it "cannot be saved with a number that is too short" do
    phone = Phone.new(number: "303")

    refute(phone.valid?)
  end

  it "cannot be saved with a number that is too long" do
    phone = Phone.new(number: "303303303303303")

    refute(phone.valid?)
  end
end
