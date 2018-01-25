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
  TYPES = %i(pair chat).freeze

  has_many :user_conversations, dependent: :destroy
  has_many :users, -> { distinct }, through: :user_conversations

  enum kind: TYPES

  scope :between_users, ->(user_ids) do
    joins(:users).where('users.id': user_ids).group('conversations.id').having('count(*) = ?', user_ids.count)
  end

  scope :ordered, -> { order(created_at: :desc) }

end