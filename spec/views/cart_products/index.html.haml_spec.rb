require 'rails_helper'

RSpec.describe "cart_products/index", type: :view do
  before(:each) do
    assign(:cart_products, [
      CartProduct.create!(
        :cart => nil,
        :product => nil,
        :quantity => 2
      ),
      CartProduct.create!(
        :cart => nil,
        :product => nil,
        :quantity => 2
      )
    ])
  end

  it "renders a list of cart_products" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
