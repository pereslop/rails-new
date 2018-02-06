namespace :messages do
  desc "messages activity"
  task messages_activity: :environment do
    User.all.each do |user|
      message_statistic = MessageStatistic.new(user, Time.now)
      MessageActivity.create(
                         user_id: user.id,
                         read_messages_count: message_statistic.messages(:read_messages_for).count,
                         unread_messages_count: message_statistic.messages(:unread_messages_for).count
      )
    end
  end
end