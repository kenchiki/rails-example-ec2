require 'rails_helper'

RSpec.describe "Admin::DeliveryTimes", type: :request do
  describe "GET /admin/delivery_times" do
    it "works! (now write some real specs)" do
      get admin_delivery_times_path
      expect(response).to have_http_status(200)
    end
  end
end
