require 'rails_helper'

RSpec.describe "admin/delivery_prices/index", type: :view do
  before(:each) do
    assign(:delivery_prices, [
      DeliveryPrice.create!(),
      DeliveryPrice.create!()
    ])
  end

  it "renders a list of admin/delivery_prices" do
    render
  end
end
