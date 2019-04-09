require 'rails_helper'

RSpec.describe "my/users/new", type: :view do
  before(:each) do
    assign(:my_user, User.new())
  end

  it "renders new my_user form" do
    render

    assert_select "form[action=?][method=?]", my_users_path, "post" do
    end
  end
end
