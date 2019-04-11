require 'rails_helper'

RSpec.describe "cash_on_deliveries/index", type: :view do
  before(:each) do
    assign(:cash_on_deliveries, [
      CashOnDelivery.create!(),
      CashOnDelivery.create!()
    ])
  end

  it "renders a list of cash_on_deliveries" do
    render
  end
end
