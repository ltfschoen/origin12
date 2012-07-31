require 'spec_helper'

describe Project do

  def attributes
    date = Date.parse '20120321'
    { description: "project description",
      manager_id: 1,
      parent_id: 2,
      name: "project name",
      short_name: "project short name",
      start_date: date,
      end_date: date,
      budget_days: 666,
      budget_amount: 666.66 }
  end

  context "attributes" do
    it_behaves_like "accessible attributes"
    it_behaves_like "default key"

    it "has a display_name" do
      project = Project.new attributes
      project.display_name.should == project.name
    end
  end

  it "has json" do
    project = Project.create! attributes
    project.to_json.should == %Q[{"id":#{project.id},"key":#{project.key},"name":"#{project.name}"}]
  end
end
