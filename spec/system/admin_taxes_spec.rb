require 'rails_helper'

describe 'admin/taxes', type: :system do
  before do
    sign_in FactoryBot.create(:user, :with_admin)
    FactoryBot.create(:tax, rate: 8)
  end

  it '#new（最後に登録された税率がフォームに初期値として反映されている）' do
    visit new_admin_tax_path

    expect(page).to have_field 'tax[rate]', with: '8.0'
  end

  it '#create（税率が追加できる）' do
    visit new_admin_tax_path

    find_field('tax[rate]').set('10')
    click_on('更新する')

    expect(find('#flash')).to have_content '税率を編集しました'

    tax = Tax.order(id: :asc).last
    expect(tax.rate).to eq 10
  end
end
