require 'rails_helper'

RSpec.describe "cash_on_deliveries/edit", type: :view do
  before(:each) do
    @cash_on_delivery = assign(:cash_on_delivery, CashOnDelivery.create!())
  end

  it "renders the edit cash_on_delivery form" do
    render

    assert_select "form[action=?][method=?]", cash_on_delivery_path(@cash_on_delivery), "post" do
    end
  end
end
