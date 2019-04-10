require 'rails_helper'

RSpec.describe "cart_products/edit", type: :view do
  before(:each) do
    @cart_product = assign(:cart_product, CartProduct.create!(
      :cart => nil,
      :product => nil,
      :quantity => 1
    ))
  end

  it "renders the edit cart_product form" do
    render

    assert_select "form[action=?][method=?]", cart_product_path(@cart_product), "post" do

      assert_select "input[name=?]", "cart_product[cart_id]"

      assert_select "input[name=?]", "cart_product[product_id]"

      assert_select "input[name=?]", "cart_product[quantity]"
    end
  end
end
