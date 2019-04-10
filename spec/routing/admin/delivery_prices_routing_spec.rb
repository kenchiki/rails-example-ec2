require "rails_helper"

RSpec.describe Admin::DeliveryPricesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/delivery_prices").to route_to("admin/delivery_prices#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/delivery_prices/new").to route_to("admin/delivery_prices#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/delivery_prices/1").to route_to("admin/delivery_prices#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/delivery_prices/1/edit").to route_to("admin/delivery_prices#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/admin/delivery_prices").to route_to("admin/delivery_prices#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/delivery_prices/1").to route_to("admin/delivery_prices#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/delivery_prices/1").to route_to("admin/delivery_prices#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/delivery_prices/1").to route_to("admin/delivery_prices#destroy", :id => "1")
    end
  end
end
