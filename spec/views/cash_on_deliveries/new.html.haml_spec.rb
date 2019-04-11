require 'rails_helper'

RSpec.describe "cash_on_deliveries/new", type: :view do
  before(:each) do
    assign(:cash_on_delivery, CashOnDelivery.new())
  end

  it "renders new cash_on_delivery form" do
    render

    assert_select "form[action=?][method=?]", _cash_on_deliveries_path, "post" do
    end
  end
end
