class UserMailer < ApplicationMailer
  default from: 'from@example.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.statistic.subject
  #
  def statistic(user, last_comments)
    @user = user
    @last_comments = last_comments
    mail to: user.email, subject: 'Statistic'
  end
end
