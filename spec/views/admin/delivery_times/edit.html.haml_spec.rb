require 'rails_helper'

RSpec.describe "admin/delivery_times/edit", type: :view do
  before(:each) do
    @admin_delivery_time = assign(:admin_delivery_time, DeliveryTime.create!())
  end

  it "renders the edit admin_delivery_time form" do
    render

    assert_select "form[action=?][method=?]", admin_delivery_time_path(@admin_delivery_time), "post" do
    end
  end
end
