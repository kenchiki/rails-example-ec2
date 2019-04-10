require "rails_helper"

RSpec.describe Admin::TaxesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/taxes").to route_to("admin/taxes#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/taxes/new").to route_to("admin/taxes#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/taxes/1").to route_to("admin/taxes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/taxes/1/edit").to route_to("admin/taxes#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/admin/taxes").to route_to("admin/taxes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/taxes/1").to route_to("admin/taxes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/taxes/1").to route_to("admin/taxes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/taxes/1").to route_to("admin/taxes#destroy", :id => "1")
    end
  end
end
