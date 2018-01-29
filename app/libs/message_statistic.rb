require 'user_statistic'
require 'date'
class MessageStatistic
  include Statistic::UserStatistic
  attr_accessor :user, :unread_messages, :read_messages, :start_time

  def initialize(user)
    @start_time = Time.now - 7.days
    @user = user
    @unread_messages = []
    @read_messages = []
    set_messages_collection
  end

  def data_for_graph
    statistic = []
    last_days.map { |day| statistic << [messages_count_per_day(@read_messages, day), messages_count_per_day(@unread_messages, day)] }
    statistic
  end

  private
    def messages_count_per_day(messages, day)
      messages = messages.flatten
      messages_count = 0
      start_time = day.midnight
      end_time = day.end_of_day
      messages.each do |message|
        messages_count += 1 if message.created_at.between?(start_time, end_time)
      end
      messages_count
    end

    def set_messages_collection
      user.conversations.each do |conversation|
        if UserConversation.seen?(conversation, @user)
          @read_messages << Message.for_conversation(conversation).created_after(@start_time)
        else
          @unread_messages << Message.for_conversation(conversation)
                                .created_after(@start_time)
                                .created_after(UserConversation.personal_for(conversation, @user).updated_at)
        end
      end
    end
end