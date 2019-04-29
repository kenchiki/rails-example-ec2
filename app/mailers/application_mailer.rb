class ApplicationMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default from: ENV.fetch('EMAIL_FROM', 'from@example.com')
  layout 'mailer'
end
