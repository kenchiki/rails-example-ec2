require 'rails_helper'

RSpec.describe "admin/taxes/edit", type: :view do
  before(:each) do
    @admin_tax = assign(:admin_tax, Tax.create!())
  end

  it "renders the edit admin_tax form" do
    render

    assert_select "form[action=?][method=?]", admin_tax_path(@admin_tax), "post" do
    end
  end
end
