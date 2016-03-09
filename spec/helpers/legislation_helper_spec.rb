require 'rails_helper'

RSpec.describe LegislationHelper, type: :helper do
  it "returns Alabama as first state" do
    expect(us_states.first.first).to eq "Alabama"
    expect(us_states.last.first).to eq "Wyoming"
  end

  it "returns California for ca abbreviation" do
    expect(full_state("ca")).to eq "California"
  end
end
