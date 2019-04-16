require 'rails_helper'

RSpec.describe "admin/orders/new", type: :view do
  before(:each) do
    assign(:admin_order, Order.new())
  end

  it "renders new admin_order form" do
    render

    assert_select "form[action=?][method=?]", admin_orders_path, "post" do
    end
  end
end
