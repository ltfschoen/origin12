require "spec_helper"

describe RosterDatesController do
  describe "routing" do

    it "routes to #index" do
      pending
      get("/roster_dates").should route_to("roster_dates#index")
    end

    it "routes to #new" do
      pending
      get("/roster_dates/new").should route_to("roster_dates#new")
    end

    it "routes to #show" do
      pending
      get("/roster_dates/1").should route_to("roster_dates#show", :id => "1")
    end

    it "routes to #edit" do
      pending
      get("/roster_dates/1/edit").should route_to("roster_dates#edit", :id => "1")
    end

    it "routes to #create" do
      pending
      post("/roster_dates").should route_to("roster_dates#create")
    end

    it "routes to #update" do
      pending
      put("/roster_dates/1").should route_to("roster_dates#update", :id => "1")
    end

    it "routes to #destroy" do
      pending
      delete("/roster_dates/1").should route_to("roster_dates#destroy", :id => "1")
    end

  end
end
