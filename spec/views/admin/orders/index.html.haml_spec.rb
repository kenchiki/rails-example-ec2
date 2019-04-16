require 'rails_helper'

RSpec.describe "admin/orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(),
      Order.create!()
    ])
  end

  it "renders a list of admin/orders" do
    render
  end
end
