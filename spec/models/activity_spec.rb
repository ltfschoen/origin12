require 'spec_helper'

describe Activity do

  def attributes
    { company_id: 666,
      default: true,
      description: 'activity',
      display_order: 1,
      key: 666 }
  end

  it_behaves_like "accessible attributes"

  it "has a default" do
    default = described_class.create! attributes
    described_class.create! attributes.merge default: false
    described_class.default.should == default
  end

end
