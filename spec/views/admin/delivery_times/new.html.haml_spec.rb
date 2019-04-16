require 'rails_helper'

RSpec.describe "admin/delivery_times/new", type: :view do
  before(:each) do
    assign(:admin_delivery_time, DeliveryTime.new())
  end

  it "renders new admin_delivery_time form" do
    render

    assert_select "form[action=?][method=?]", admin_delivery_times_path, "post" do
    end
  end
end
