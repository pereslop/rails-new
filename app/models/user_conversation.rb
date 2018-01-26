class UserConversation < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  accepts_nested_attributes_for :conversation

  scope :for_conversation, ->(conversation) { find_by!(conversation_id: conversation.id) }

  def self.read_conversation(conversation)
    for_conversation(conversation).touch
  end

  def self.seen?(conversation, user)
    personal_for(conversation, user).updated_at <= last_activity_time(conversation) ? false : true
  end

  def self.personal_for(conversation, user)
    user.user_conversations.for_conversation(conversation)
  end

  def self.last_activity_time(conversation)
    messages = Message.for_conversation(conversation)
    if messages.empty?
      conversation.created_at
    else
      messages.asc(:created_at).last.created_at
    end
  end
end