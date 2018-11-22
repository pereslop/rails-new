class AddUserIdAndConversationIidToUserConversations < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_conversations, :user, foreign_key: true
    add_reference :user_conversations, :conversation, foreign_key: true
  end
end
