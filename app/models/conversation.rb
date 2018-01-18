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
  has_many :conversations_users
  has_many :users, through: :conversations_users

  scope :between_users, ->(user_ids) do
    joins(:users).where('users.id': user_ids).group('conversations.id').having('count(*) = ?', user_ids.count)
  end

  def find_or_create_conversation

  end
end