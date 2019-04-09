require 'rails_helper'

RSpec.describe "My::Users", type: :request do
  describe "GET /my/users" do
    it "works! (now write some real specs)" do
      get my_users_path
      expect(response).to have_http_status(200)
    end
  end
end
