require 'spec_helper'

describe Roster do

  let(:date) { Date.parse "20120321" }

  def attributes
    { customer_id: 1,
      project_id: 1,
      # roster_date: date,
      activity_id: 1,
      description: "description",
      hours: 8,
      shift: 1 }
  end

  context "attributes" do
    fixtures :roster_dates

    it_behaves_like "accessible attributes"
    it_behaves_like "default key"

    it "is not valid without a project_id" do
      pending
      Roster.new(attributes.extract!(:project_id)).should_not be_valid
    end

    it "has a default activity" do
      pending
      activity = double(:activity)
      Activity.stub(:default).and_return(activity)
      Roster.new.activity.should == activity
    end
  end

end
