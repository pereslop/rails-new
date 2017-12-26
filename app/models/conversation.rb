# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :users

  scope :for_users, -> (user_ids) do
    Conversation.joins(:user_conversations).where(user_conversations: { user_id: user_ids }).group('conversations.id').having("COUNT(user_conversations.user_id) = #{user_ids.size}")
  end
end
