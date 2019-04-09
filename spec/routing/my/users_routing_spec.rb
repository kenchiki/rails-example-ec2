require "rails_helper"

RSpec.describe My::UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/my/users").to route_to("my/users#index")
    end

    it "routes to #new" do
      expect(:get => "/my/users/new").to route_to("my/users#new")
    end

    it "routes to #show" do
      expect(:get => "/my/users/1").to route_to("my/users#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/my/users/1/edit").to route_to("my/users#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/my/users").to route_to("my/users#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/my/users/1").to route_to("my/users#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/my/users/1").to route_to("my/users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/my/users/1").to route_to("my/users#destroy", :id => "1")
    end
  end
end
