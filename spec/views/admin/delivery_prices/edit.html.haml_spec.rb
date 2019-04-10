require 'rails_helper'

RSpec.describe "admin/delivery_prices/edit", type: :view do
  before(:each) do
    @admin_delivery_price = assign(:admin_delivery_price, DeliveryPrice.create!())
  end

  it "renders the edit admin_delivery_price form" do
    render

    assert_select "form[action=?][method=?]", admin_delivery_price_path(@admin_delivery_price), "post" do
    end
  end
end
