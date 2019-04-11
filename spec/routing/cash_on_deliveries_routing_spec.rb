require "rails_helper"

RSpec.describe CashOnDeliveriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/cash_on_deliveries").to route_to("cash_on_deliveries#index")
    end

    it "routes to #new" do
      expect(:get => "/cash_on_deliveries/new").to route_to("cash_on_deliveries#new")
    end

    it "routes to #show" do
      expect(:get => "/cash_on_deliveries/1").to route_to("cash_on_deliveries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cash_on_deliveries/1/edit").to route_to("cash_on_deliveries#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/cash_on_deliveries").to route_to("cash_on_deliveries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cash_on_deliveries/1").to route_to("cash_on_deliveries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cash_on_deliveries/1").to route_to("cash_on_deliveries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cash_on_deliveries/1").to route_to("cash_on_deliveries#destroy", :id => "1")
    end
  end
end
