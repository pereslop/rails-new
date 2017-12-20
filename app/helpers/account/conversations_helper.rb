module Account::ConversationsHelper
 def conversations_users(conversation)
   users = []
   conversation.messages.each do |message|
    users << User.find(message.user_id)
   end
   users.uniq.without(current_user)
 end
end
