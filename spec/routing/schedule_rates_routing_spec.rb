require "spec_helper"

describe ScheduleRatesController do
  describe "routing" do

    it "routes to #index" do
      pending
      get("/schedule_rates").should route_to("schedule_rates#index")
    end

    it "routes to #new" do
      pending
      get("/schedule_rates/new").should route_to("schedule_rates#new")
    end

    it "routes to #show" do
      pending
      get("/schedule_rates/1").should route_to("schedule_rates#show", :id => "1")
    end

    it "routes to #edit" do
      pending
      get("/schedule_rates/1/edit").should route_to("schedule_rates#edit", :id => "1")
    end

    it "routes to #create" do
      pending
      post("/schedule_rates").should route_to("schedule_rates#create")
    end

    it "routes to #update" do
      pending
      put("/schedule_rates/1").should route_to("schedule_rates#update", :id => "1")
    end

    it "routes to #destroy" do
      pending
      delete("/schedule_rates/1").should route_to("schedule_rates#destroy", :id => "1")
    end

  end
end
