# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  body            :text
#  conversation_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :body, presence: true, length: { maximum: 250 }
end
