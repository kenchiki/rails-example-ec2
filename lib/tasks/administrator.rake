# frozen_string_literal: true

# usage:`rails administrator:become USER_ID=1`
namespace :administrator do
  desc 'ユーザーを管理者に設定する'
  task become: :environment do
    user_id = ENV.fetch('USER_ID')
    user = User.find(user_id)
    user.update_column(:admin, true) # validationを走らせたくないのでupdate_column
  end
end
