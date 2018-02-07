require 'user_statistic'

class MessageStatistic
  include Statistic::UserStatistic

  attr_accessor :user, :day

  def initialize(user, day)
    @day = day
    @user = user
  end

  def data_for_graph
    last_days.inject([]) do |memo, time|
      message_activity_statistic = MessageActivity.for_user(@user).for_whole_day(time).pluck(:read_messages_count, :unread_messages_count)
      if message_activity_statistic.empty?
        memo += [[0, 0]]
      else
        memo += message_activity_statistic
      end
    end
  end

  def messages(scope)
    @user.conversations.inject([]) { |memo, conversation| memo += user.public_send(scope, conversation, day) }
  end
end