require "rails_helper"

RSpec.describe Api::PeopleController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/people").to route_to("api/people#index")
    end

    it "routes to #show" do
      expect(:get => "/api/people/1").to route_to("api/people#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/api/people").to route_to("api/people#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/people/1").to route_to("api/people#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/people/1").to route_to("api/people#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/people/1").to route_to("api/people#destroy", :id => "1")
    end
  end
end
