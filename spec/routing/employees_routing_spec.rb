require "spec_helper"

describe EmployeesController do
  describe "routing" do

    it "routes to #index" do
      pending
      get("/employees").should route_to("employees#index")
    end

    it "routes to #new" do
      pending
      get("/employees/new").should route_to("employees#new")
    end

    it "routes to #show" do
      pending
      get("/employees/1").should route_to("employees#show", :id => "1")
    end

    it "routes to #edit" do
      pending
      get("/employees/1/edit").should route_to("employees#edit", :id => "1")
    end

    it "routes to #create" do
      pending
      post("/employees").should route_to("employees#create")
    end

    it "routes to #update" do
      pending
      put("/employees/1").should route_to("employees#update", :id => "1")
    end

    it "routes to #destroy" do
      pending
      delete("/employees/1").should route_to("employees#destroy", :id => "1")
    end

  end
end
