require "spec_helper"

describe MotsController do
  describe "routing" do

    it "routes to #index" do
      get("/mots").should route_to("mots#index")
    end

    it "routes to #new" do
      get("/mots/new").should route_to("mots#new")
    end

    it "routes to #show" do
      get("/mots/1").should route_to("mots#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mots/1/edit").should route_to("mots#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mots").should route_to("mots#create")
    end

    it "routes to #update" do
      put("/mots/1").should route_to("mots#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mots/1").should route_to("mots#destroy", :id => "1")
    end

  end
end
