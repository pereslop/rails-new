module Account::ConversationsHelper
 def conversations_users(conversation)
   conversation.users.without_user(current_user)
   User.first
 end
end
