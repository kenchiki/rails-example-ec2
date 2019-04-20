require 'rails_helper'

describe 'admin/users', type: :system do
  before do
    sign_in FactoryBot.create(:user, :with_admin)
  end

  it '#update（ユーザーが編集できる）' do
    user = FactoryBot.create(:user)

    visit edit_admin_user_path(user)

    find('#user_email').set('test2@example.com')
    find(".edit_user [type='submit']").click

    expect(find('#flash')).to have_content 'ユーザーを編集しました'

    user.reload
    token = user.confirmation_token
    visit user_confirmation_path(confirmation_token: token)
    expect(find('#flash')).to have_content 'アカウントを登録しました。'

    user.reload
    expect(user.email).to eq 'test2@example.com'
  end

  it '#destroy（ユーザーが削除できる）' do
    user = FactoryBot.create(:user)

    visit admin_users_path
    expect do
      accept_confirm do
        find("[data-method='delete'][href='#{admin_user_path(user)}']").click
      end
      expect(find('#flash')).to have_content 'ユーザーを削除しました'
    end.to change(User, :count).by(-1)
  end

  it '#index（ユーザー一覧が閲覧できる）' do
    user = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)

    visit admin_users_path

    table = find(:test, 'users__index')
    expect(table).to have_link '詳細', href: admin_user_path(user)
    expect(table).to have_link '詳細', href: admin_user_path(user2)
  end

  it '#show（ユーザーの情報を閲覧できる）' do
    user = FactoryBot.create(:user, email: 'test2@example.com')

    visit admin_user_path(user)

    expect(find(:test, 'users__show')).to have_content 'test2@example.com'
  end
end
