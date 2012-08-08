require 'spec_helper'

describe "roles/edit" do
  before(:each) do
    @role = assign(:role, stub_model(Role,
      :parent_id => 1,
      :name => "MyString"
    ))
  end

  it "renders the edit role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => roles_path(@role), :method => "post" do
      assert_select "input#role_parent_id", :name => "role[parent_id]"
      assert_select "input#role_name", :name => "role[name]"
    end
  end
end
