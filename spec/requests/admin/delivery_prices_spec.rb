require 'rails_helper'

RSpec.describe "Admin::DeliveryPrices", type: :request do
  describe "GET /admin/delivery_prices" do
    it "works! (now write some real specs)" do
      get admin_delivery_prices_path
      expect(response).to have_http_status(200)
    end
  end
end
