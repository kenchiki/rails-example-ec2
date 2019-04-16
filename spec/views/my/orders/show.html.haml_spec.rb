require 'rails_helper'

RSpec.describe "my/orders/show", type: :view do
  before(:each) do
    @my_order = assign(:my_order, Order.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
