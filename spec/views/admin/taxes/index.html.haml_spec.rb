require 'rails_helper'

RSpec.describe "admin/taxes/index", type: :view do
  before(:each) do
    assign(:taxes, [
      Tax.create!(),
      Tax.create!()
    ])
  end

  it "renders a list of admin/taxes" do
    render
  end
end
