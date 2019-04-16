require 'rails_helper'

RSpec.describe "My::Orders", type: :request do
  describe "GET /my/orders" do
    it "works! (now write some real specs)" do
      get my_orders_path
      expect(response).to have_http_status(200)
    end
  end
end
