module Account::ConversationsHelper
 def conversation_name(conversation)
   return conversation.title if conversation.chat?
   conversation.users.without_user(current_user).first.username
 end
end
