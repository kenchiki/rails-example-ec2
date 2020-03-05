require 'rails_helper'

describe 'admin/users', type: :system do
  before do
    sign_in FactoryBot.create(:user, :with_admin)
  end

  describe '#update' do
    it 'ユーザーが編集できる' do
      user = FactoryBot.create(:user, email: 'test2@example.com')

      visit edit_admin_user_path(user)

      find_field('user[email]').set('test3@example.com')
      find("[name$='[full_name]']").set('テスト氏名')
      find("[name$='[post]']").set('111-1111')
      find("[name$='[tel]']").set('222-2222-2222')
      find("[name$='[address]']").set('テスト県テスト市テスト町1-1-1')
      click_on('更新する')

      expect(find('#flash')).to have_content 'ユーザーを編集しました'

      user.reload
      token = user.confirmation_token
      visit user_confirmation_path(confirmation_token: token)
      expect(find('#flash')).to have_content 'アカウントを登録しました。'

      user.reload
      expect(user.email).to eq 'test3@example.com'
      expect(user.full_name).to eq 'テスト氏名'
      expect(user.post).to eq '111-1111'
      expect(user.tel).to eq '222-2222-2222'
      expect(user.address).to eq 'テスト県テスト市テスト町1-1-1'
    end
  end

  describe '#destroy' do
    it 'ユーザーが削除できる' do
      user = FactoryBot.create(:user)

      visit admin_users_path
      expect do
        accept_confirm do
          find_link('削除', href: admin_user_path(user)).click
          # find_link("[data-method='delete'][href='#{admin_user_path(user)}']").click
        end
        expect(find('#flash')).to have_content 'ユーザーを削除しました'
      end.to change(User, :count).by(-1)
    end
  end

  describe '#index' do
    it 'ユーザー一覧が閲覧できる' do
      user = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)

      visit admin_users_path

      table = find(:test, 'users__index')
      expect(table).to have_link '詳細', href: admin_user_path(user)
      expect(table).to have_link '詳細', href: admin_user_path(user2)
    end
  end

  describe '#show' do
    it 'ユーザーの情報を閲覧できる' do
      user = FactoryBot.create(:user, email: 'test2@example.com')
      user.shipping_addresses.create(
        full_name: 'テスト氏名', post: '111-1111', tel: '222-2222-2222', address: 'テスト県テスト市テスト町1-1-1'
      )

      visit admin_user_path(user)

      target = find(:test, 'users__show')
      expect(target).to have_content 'test2@example.com'
      expect(target).to have_content 'テスト氏名'
      expect(target).to have_content '111-1111'
      expect(target).to have_content '222-2222-2222'
      expect(target).to have_content 'テスト県テスト市テスト町1-1-1'
    end
  end
end
