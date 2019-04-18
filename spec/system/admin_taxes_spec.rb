require 'rails_helper'

describe 'admin/taxes', type: :system do
  before do
    sign_in FactoryBot.create(:user, :with_admin)
    FactoryBot.create(:tax, rate: 8)
  end

  it '#create（税率が追加できる）' do
    visit new_admin_tax_path
    find('#tax_rate').set('10')
    find(".edit_tax [type='submit']").click

    tax = Tax.order(id: :asc).last
    expect(find('#flash')).to have_content '税率を編集しました'
    expect(tax.rate).to eq 10
  end
end
