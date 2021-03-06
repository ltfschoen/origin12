require "spec_helper"

describe CompaniesController do
  describe "routing" do

    it "routes to #index" do
      pending
      get("/companies").should route_to("companies#index")
    end

    it "routes to #new" do
      pending
      get("/companies/new").should route_to("companies#new")
    end

    it "routes to #show" do
      pending
      get("/companies/1").should route_to("companies#show", :id => "1")
    end

    it "routes to #edit" do
      pending
      get("/companies/1/edit").should route_to("companies#edit", :id => "1")
    end

    it "routes to #create" do
      pending
      post("/companies").should route_to("companies#create")
    end

    it "routes to #update" do
      pending
      put("/companies/1").should route_to("companies#update", :id => "1")
    end

    it "routes to #destroy" do
      pending
      delete("/companies/1").should route_to("companies#destroy", :id => "1")
    end

  end
end
