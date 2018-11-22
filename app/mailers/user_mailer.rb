require 'user_statistic'
class UserMailer < ApplicationMailer
  include Admin::UsersHelper
  include Account::UsersHelper

  default from: 'from@example.com'

  def statistic(user, last_comments)
    @user = user
    @last_comments = last_comments
    attachments.inline['name.png'] = png(comments_graph(@last_comments))
    mail to: user.email, subject: 'Statistic'
  end

  def messages_statistic(user)
    @user = user
    attachments.inline['messages_graph.png'] = png(line_chart(@user))
    mail to: @user.email, subject: 'Messenger activity'
  end
end
