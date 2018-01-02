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
  has_and_belongs_to_many :users

  scope :between_users, ->(user_ids) do
    joins(:users).where('users.id': user_ids).group('conversations.id').having('count(*) = ?', user_ids.count).to_a
  end
end
