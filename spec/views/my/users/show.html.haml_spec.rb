require 'rails_helper'

RSpec.describe "my/users/show", type: :view do
  before(:each) do
    @my_user = assign(:my_user, User.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
