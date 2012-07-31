require 'spec_helper'

describe Customer do

  def attributes
    { key: 666, name: 'Acme' }
  end

  context "attributes" do
    it_behaves_like "accessible attributes"

    it "has a short name" do
      customer = described_class.new attributes
      customer.short_name.should == customer.name
    end

    it "has a display_name" do
      customer = described_class.new attributes
      customer.display_name.should == customer.name
    end

    it "has a default key from id" do
      customer = described_class.create! attributes.except :key
      customer.reload.key.should == customer.id.to_s
    end
  end

end
