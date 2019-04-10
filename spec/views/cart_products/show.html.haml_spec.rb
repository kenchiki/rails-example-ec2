require 'rails_helper'

RSpec.describe "cart_products/show", type: :view do
  before(:each) do
    @cart_product = assign(:cart_product, CartProduct.create!(
      :cart => nil,
      :product => nil,
      :quantity => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
