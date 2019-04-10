require 'rails_helper'

RSpec.describe "admin/taxes/show", type: :view do
  before(:each) do
    @admin_tax = assign(:admin_tax, Tax.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
