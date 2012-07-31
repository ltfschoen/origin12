require 'spec_helper'

describe Company do

  fixtures :companies, :employees

  def attributes
    { key: 666, name: 'acme' }
  end

  context "attributes" do
    it_behaves_like "accessible attributes"

    it "has a display name" do
      company = described_class.new attributes
      company.display_name.should == company.name
    end
  end

  it "has managers" do
    company = companies(:origin12)
    company.employees << employees(:michael) << employees(:hernus)
    company.reload.employees.should == [ employees(:michael), employees(:hernus) ]
  end

  it 'has children' do
    parent = companies(:origin12)
    child = described_class.new attributes
    parent.children << child
    parent.reload.self_and_children.should == [ parent, child ]
  end

end
