require 'rails_helper'

RSpec.describe "admin/delivery_prices/new", type: :view do
  before(:each) do
    assign(:admin_delivery_price, DeliveryPrice.new())
  end

  it "renders new admin_delivery_price form" do
    render

    assert_select "form[action=?][method=?]", admin_delivery_prices_path, "post" do
    end
  end
end
