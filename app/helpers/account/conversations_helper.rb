module Account::ConversationsHelper
 def conversation_name(conversation)
   return conversation.title if conversation.chat?
   conversation.users.without_user(current_user).first.username
 end

 def message_text(message)
   MessageBody.for_message(message).body
 end
end
