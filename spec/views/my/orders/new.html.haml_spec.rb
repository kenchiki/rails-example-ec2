require 'rails_helper'

RSpec.describe "my/orders/new", type: :view do
  before(:each) do
    assign(:my_order, Order.new())
  end

  it "renders new my_order form" do
    render

    assert_select "form[action=?][method=?]", my_orders_path, "post" do
    end
  end
end
