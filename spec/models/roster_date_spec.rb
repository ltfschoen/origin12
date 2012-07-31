require 'spec_helper'

describe RosterDate do

  # Wednesday, March 21, 2012
  let(:date) { Date.parse "20120321" }

  def attributes
    { date: date,
      company_id: 1,
      employee_id: 1,
      locked: true }
  end

  context "attributes" do
    it_behaves_like "accessible attributes"

    context "date" do
      before :each do
        RosterDate.create! attributes
      end

      it "is not valid when not unique for company and employee" do
        roster_date = RosterDate.new attributes
        roster_date.should_not be_valid
      end

      it "is valid when unique for company" do
        roster_date = RosterDate.new attributes.merge(company_id: 2)
        roster_date.should be_valid
      end

      it "is valid when unique for employee" do
        roster_date = RosterDate.new attributes.merge(employee_id: 2)
        roster_date.should be_valid
      end

      it "is valid when unique for employee and company" do
        roster_date = RosterDate.new attributes.merge(company_id: 2, employee_id: 2)
        roster_date.should be_valid
      end
    end
  end

  context "scopes" do
    fixtures :companies

    before :each do
      0.upto(7) do |idx|
        RosterDate.create! attributes.merge(date: date + idx.days)
      end
    end

    it "to wdays" do
      wednesdays = [ Date.parse("20120321"), Date.parse("20120328") ]
      RosterDate.wdays(3).map(&:date).should == wednesdays
    end

    it "to company" do
      company = mock(:company, :[] => 2)
      roster_date = RosterDate.create! attributes.merge(company_id: company[:id])
      RosterDate.company(company).should == [ roster_date ]
    end

    it "to locked" do
      roster_date = RosterDate.create! attributes.merge locked: false, employee_id: 2
      RosterDate.unlocked.should == [ roster_date ]
    end
  end

end
