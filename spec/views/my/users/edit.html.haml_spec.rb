require 'rails_helper'

RSpec.describe "my/users/edit", type: :view do
  before(:each) do
    @my_user = assign(:my_user, User.create!())
  end

  it "renders the edit my_user form" do
    render

    assert_select "form[action=?][method=?]", my_user_path(@my_user), "post" do
    end
  end
end
