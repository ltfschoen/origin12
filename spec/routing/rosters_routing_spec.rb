require "spec_helper"

describe RostersController do
  describe "routing" do

    it "routes to #index" do
      pending
      get("/rosters").should route_to("rosters#index")
    end

    it "routes to #new" do
      pending
      get("/rosters/new").should route_to("rosters#new")
    end

    it "routes to #show" do
      pending
      get("/rosters/1").should route_to("rosters#show", :id => "1")
    end

    it "routes to #edit" do
      pending
      get("/rosters/1/edit").should route_to("rosters#edit", :id => "1")
    end

    it "routes to #create" do
      pending
      post("/rosters").should route_to("rosters#create")
    end

    it "routes to #update" do
      pending
      put("/rosters/1").should route_to("rosters#update", :id => "1")
    end

    it "routes to #destroy" do
      pending
      delete("/rosters/1").should route_to("rosters#destroy", :id => "1")
    end

  end
end
