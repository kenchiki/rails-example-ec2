require "rails_helper"

RSpec.describe My::OrdersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/my/orders").to route_to("my/orders#index")
    end

    it "routes to #new" do
      expect(:get => "/my/orders/new").to route_to("my/orders#new")
    end

    it "routes to #show" do
      expect(:get => "/my/orders/1").to route_to("my/orders#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/my/orders/1/edit").to route_to("my/orders#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/my/orders").to route_to("my/orders#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/my/orders/1").to route_to("my/orders#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/my/orders/1").to route_to("my/orders#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/my/orders/1").to route_to("my/orders#destroy", :id => "1")
    end
  end
end
