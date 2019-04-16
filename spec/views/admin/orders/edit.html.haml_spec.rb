require 'rails_helper'

RSpec.describe "admin/orders/edit", type: :view do
  before(:each) do
    @admin_order = assign(:admin_order, Order.create!())
  end

  it "renders the edit admin_order form" do
    render

    assert_select "form[action=?][method=?]", admin_order_path(@admin_order), "post" do
    end
  end
end
