require 'user_statistic'
class UserMailer < ApplicationMailer
  include Admin::UsersHelper

  default from: 'from@example.com'

  def statistic(user, last_comments)
    @user = user
    @last_comments = last_comments
    attachments.inline['name.png'] = png(comments_graph(@last_comments))
    mail to: user.email, subject: 'Statistic'
  end
end
