require 'rails_helper'

RSpec.describe "my/users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(),
      User.create!()
    ])
  end

  it "renders a list of my/users" do
    render
  end
end
