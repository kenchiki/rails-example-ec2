require 'rails_helper'

describe '認証', type: :system do
  it 'サインアップ後、ログインできる' do
    user_attributes = FactoryBot.attributes_for(:user)

    # サインアップ
    visit new_user_registration_path
    find_field('user[email]').set(user_attributes[:email])
    find_field('user[password]').set(user_attributes[:password])
    find_field('user[password_confirmation]').set(user_attributes[:password])
    expect { click_on('サインアップ') }.to change { ActionMailer::Base.deliveries.size }.by(1)

    # ログイン
    user = User.last
    token = user.confirmation_token
    visit user_confirmation_path(confirmation_token: token)

    find_field('user[email]').set(user_attributes[:email])
    find_field('user[password]').set(user_attributes[:password])
    find('#container').click_on('ログイン')

    expect(find('#flash')).to have_content 'ログインしました。'
    expect(current_path).to eq root_path
  end

  it 'パスワードを忘れた場合の再設定できる' do
    user_attributes = FactoryBot.attributes_for(:user)
    user = FactoryBot.create(:user, user_attributes)

    # パスワード再発行
    visit new_user_password_path
    find_field('user[email]').set(user.email)
    click_on('パスワード再設定を送信する')

    reset_token = user.send_reset_password_instructions
    visit edit_user_password_path(reset_password_token: reset_token)
    find_field('user[password]').set(user_attributes[:password])
    find_field('user[password_confirmation]').set(user_attributes[:password])
    click_on('パスワードを変更')

    expect(find('#flash')).to have_content 'パスワードが正しく変更されました。'
    expect(current_path).to eq root_path
  end

  it '確認メールが届かなかった場合の再送できる' do
    user_attributes = FactoryBot.attributes_for(:user)

    # サインアップ
    visit new_user_registration_path
    find_field('user[email]').set(user_attributes[:email])
    find_field('user[password]').set(user_attributes[:password])
    find_field('user[password_confirmation]').set(user_attributes[:password])
    expect { click_on('サインアップ') }.to change { ActionMailer::Base.deliveries.size }.by(1)

    # メール再送
    visit new_user_confirmation_path
    find_field('user[email]').set(user_attributes[:email])
    expect { click_on('確認メールを再送') }.to change { ActionMailer::Base.deliveries.size }.by(1)

    expect(find('#flash')).to have_content 'アカウントの有効化について数分以内にメールでご連絡します。'
    expect(current_path).to eq new_user_session_path
  end
end
