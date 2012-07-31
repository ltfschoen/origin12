require 'spec_helper'

describe Employee do

  def attributes
    date = Date.parse "20120321"
    { key: 666,
      first_name: "John",
      last_name: "Citizen",
      started_at: date,
      terminated_at: date }
  end

  context "attributes" do
    it_behaves_like "accessible attributes"

    it "has a full name" do
      employee = Employee.new attributes
      employee.full_name.should == "John Citizen"
    end
  end

  context "scopes" do

    fixtures :employees, :companies
    it "to a company" do
      employee = employees(:hernus)
      company = companies(:origin12)
      company.employees << employee
      Employee.company(company).should == [ employee ]
    end
  end

end
