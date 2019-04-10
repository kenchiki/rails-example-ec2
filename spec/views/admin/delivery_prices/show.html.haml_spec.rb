require 'rails_helper'

RSpec.describe "admin/delivery_prices/show", type: :view do
  before(:each) do
    @admin_delivery_price = assign(:admin_delivery_price, DeliveryPrice.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
