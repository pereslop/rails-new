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

class Message
  include Cequel::Record
  key :id, :timeuuid, auto: true
  column :user_id, :int, index: true
  column :conversation_id, :int, index: true
  column :body, :text

  timestamps

  validates :user_id, presence: true
  validates :conversation_id, presence: true
  validates :body, presence: true

  def self.for_conversation(conversation)
   where(conversation_id: conversation.id).to_a.sort_by{|e| e[:updated_at]}.reverse!
  end

  def body

  end
end
