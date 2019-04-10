require 'rails_helper'

RSpec.describe "Admin::Taxes", type: :request do
  describe "GET /admin/taxes" do
    it "works! (now write some real specs)" do
      get admin_taxes_path
      expect(response).to have_http_status(200)
    end
  end
end
