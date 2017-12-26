module Account::ConversationsHelper
 def conversations_users(conversation)
   conversation.users.where.not(id: current_user.id)
 end
end
