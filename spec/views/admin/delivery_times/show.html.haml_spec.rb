require 'rails_helper'

RSpec.describe "admin/delivery_times/show", type: :view do
  before(:each) do
    @admin_delivery_time = assign(:admin_delivery_time, DeliveryTime.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
