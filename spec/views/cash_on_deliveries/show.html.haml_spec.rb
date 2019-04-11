require 'rails_helper'

RSpec.describe "cash_on_deliveries/show", type: :view do
  before(:each) do
    @cash_on_delivery = assign(:cash_on_delivery, CashOnDelivery.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
