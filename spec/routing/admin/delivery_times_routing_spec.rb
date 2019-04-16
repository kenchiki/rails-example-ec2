require "rails_helper"

RSpec.describe Admin::DeliveryTimesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/delivery_times").to route_to("admin/delivery_times#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/delivery_times/new").to route_to("admin/delivery_times#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/delivery_times/1").to route_to("admin/delivery_times#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/delivery_times/1/edit").to route_to("admin/delivery_times#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/admin/delivery_times").to route_to("admin/delivery_times#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/delivery_times/1").to route_to("admin/delivery_times#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/delivery_times/1").to route_to("admin/delivery_times#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/delivery_times/1").to route_to("admin/delivery_times#destroy", :id => "1")
    end
  end
end
