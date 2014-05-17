require "spec_helper"

describe VerbesController do
  describe "routing" do

    it "routes to #index" do
      get("/verbes").should route_to("verbes#index")
    end

    it "routes to #new" do
      get("/verbes/new").should route_to("verbes#new")
    end

    it "routes to #show" do
      get("/verbes/1").should route_to("verbes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/verbes/1/edit").should route_to("verbes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/verbes").should route_to("verbes#create")
    end

    it "routes to #update" do
      put("/verbes/1").should route_to("verbes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/verbes/1").should route_to("verbes#destroy", :id => "1")
    end

  end
end
