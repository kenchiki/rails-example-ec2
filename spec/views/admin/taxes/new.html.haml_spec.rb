require 'rails_helper'

RSpec.describe "admin/taxes/new", type: :view do
  before(:each) do
    assign(:admin_tax, Tax.new())
  end

  it "renders new admin_tax form" do
    render

    assert_select "form[action=?][method=?]", admin_taxes_path, "post" do
    end
  end
end
