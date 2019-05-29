# ECサイト

Rails製のショッピングカートです。
[動作イメージ](https://nagai-galaxy.com/screenshot/rails-assignment-ec2.gif)

## 動作環境
- ruby 2.6.0
- rails 5.2.3

## 管理者設定方法
`rails administrator:become USER_ID=1`

## デモ用データ作成
`rails sample:create_demo`

# 本番環境で設定する環境変数
```ruby
# herokuでは○○.herokuapp.comを設定
ACTION_MAILER_DOMAIN

# herokuでは○○.herokuapp.comを設定
ACTION_MAILER_HOST

# herokuでは設定不要（未設定の場合、ENV['ACTION_MAILER_PORT']はnilになる）
ACTION_MAILER_PORT

# herokuのSENDGRIDプラグインで自動で設定される
SENDGRID_USERNAME

# herokuのSENDGRIDプラグインで自動で設定される
SENDGRID_PASSWORD

# awsの設定
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
AWS_HOST
AWS_ENDPOINT
AWS_BUCKET

# メールアドレス送信時のFROM
EMAIL_FROM

# デモadminユーザーパスワード（必要であれば）
DEMO_ADMIN_USER_PASSWORD

# デモユーザーパスワード（必要であれば）
DEMO_USER_PASSWORD
```
