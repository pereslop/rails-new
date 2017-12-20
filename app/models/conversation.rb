class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :user_conversations, dependent: :destroy
  has_many :users, through: :user_conversations

  scope :for_users, -> (user_ids) do
    Conversation.joins(:user_conversations).where(user_conversations: { user_id: user_ids }).group('conversations.id').having("COUNT(user_conversations.user_id) = #{user_ids.size}")
  end
end
