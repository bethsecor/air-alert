require 'rails_helper'

RSpec.describe Phone, type: :model do
  it "takes out non-number characters ans adds US country code if not provided" do
    phone = Phone.create(number: "(999) 999-9999")

    expect(phone.number).to eq "19999999999"
  end
end
