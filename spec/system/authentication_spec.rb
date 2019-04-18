require 'rails_helper'

describe '認証', type: :system do
  it 'サインアップ後、ログイン' do
    user_attributes = FactoryBot.attributes_for(:user)

    # サインアップ
    visit new_user_registration_path
    find('#user_email').set(user_attributes[:email])
    find('#user_password').set(user_attributes[:password])
    find('#user_password_confirmation').set(user_attributes[:password])
    expect { find("#new_user [name='commit']").click }.to change { ActionMailer::Base.deliveries.size }.by(1)

    # ログイン
    user = User.last
    token = user.confirmation_token
    visit user_confirmation_path(confirmation_token: token)
    find('#user_email').set(user_attributes[:email])
    find('#user_password').set(user_attributes[:password])
    find("#new_user [name='commit']").click
    expect(find('#flash')).to have_content 'ログインしました。'
  end

  it 'パスワードを忘れた場合の再発行' do
    user_attributes = FactoryBot.attributes_for(:user)
    user = FactoryBot.create(:user, user_attributes)

    # パスワード再発行
    visit new_user_password_path
    find('#user_email').set(user.email)
    find("#new_user [name='commit']").click

    reset_token = user.send_reset_password_instructions
    visit edit_user_password_path(reset_password_token: reset_token)
    find('#user_password').set(user_attributes[:password])
    find('#user_password_confirmation').set(user_attributes[:password])
    find("#new_user [name='commit']").click
    expect(find('#flash')).to have_content 'パスワードが正しく変更されました。'
  end
end
