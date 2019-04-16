require 'rails_helper'

RSpec.describe "admin/delivery_times/index", type: :view do
  before(:each) do
    assign(:delivery_times, [
      DeliveryTime.create!(),
      DeliveryTime.create!()
    ])
  end

  it "renders a list of admin/delivery_times" do
    render
  end
end
