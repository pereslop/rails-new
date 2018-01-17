module Account::ConversationsHelper
 def conversations_users(conversation)
   conversation.users.without_user(current_user)
 end

 def message_body(message)
   MessageBody.for_message(message).body
 end
end
