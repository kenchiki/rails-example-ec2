require 'rails_helper'

RSpec.describe "my/orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(),
      Order.create!()
    ])
  end

  it "renders a list of my/orders" do
    render
  end
end
