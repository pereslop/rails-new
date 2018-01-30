class UserConversation < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validate :unique_in_conversation

  scope :for_conversation, ->(conversation) { find_by!(conversation_id: conversation.id) }

  def self.read_conversation(conversation)
    for_conversation(conversation).touch
  end

  def self.seen?(conversation, user)
    personal_for(conversation, user).updated_at >= last_activity_time(conversation)
  end

  def self.personal_for(conversation, user)
    user.user_conversations.for_conversation(conversation)
  end

  def self.last_activity_time(conversation)
    messages = Message.for_conversation(conversation)
    if messages.empty?
      conversation.created_at
    else
      messages.last_created_at.created_at
    end
  end

  private

  def unique_in_conversation
    binding.pry
    if UserConversation.where(conversation_id: self.conversation_id, user_id: self.user_id).present?
      errors.add(:uniqueness, 'you can\'t  save two  identical user_conversations to one conversation'  )
    end
  end
end