require "spec_helper"

describe CustomersController do
  describe "routing" do

    it "routes to #index" do
      pending
      get("/customers").should route_to("customers#index")
    end

    it "routes to #new" do
      pending
      get("/customers/new").should route_to("customers#new")
    end

    it "routes to #show" do
      pending
      get("/customers/1").should route_to("customers#show", :id => "1")
    end

    it "routes to #edit" do
      pending
      get("/customers/1/edit").should route_to("customers#edit", :id => "1")
    end

    it "routes to #create" do
      pending
      post("/customers").should route_to("customers#create")
    end

    it "routes to #update" do
      pending
      put("/customers/1").should route_to("customers#update", :id => "1")
    end

    it "routes to #destroy" do
      pending
      delete("/customers/1").should route_to("customers#destroy", :id => "1")
    end

  end
end
