class ApplicationMailer < ActionMailer::Base
  add_template_helper Admin::UsersHelper
  default from: 'from@example.com'
  layout 'mailer'
end

