require 'rails_helper'

RSpec.describe "admin/orders/show", type: :view do
  before(:each) do
    @admin_order = assign(:admin_order, Order.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
