class UserConversation < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validate :unique_for_conversation

  scope :for_conversation, ->(conversation) { find_by!(conversation_id: conversation.id) }

  def self.read_conversation(conversation)
    for_conversation(conversation).touch
  end


  def self.personal_for(conversation, user)
    user.user_conversations.for_conversation(conversation)
  end


  private

  def unique_for_conversation
    if UserConversation.where(conversation_id: self.conversation_id, user_id: self.user_id).present?
      errors.add(:uniqueness, 'you can\'t  save two  identical user_conversations to one conversation'  )
    end
  end
end