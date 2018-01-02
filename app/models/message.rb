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
  column :user_id, :text, index: true
  column :conversation_id, :text, index: true
  column :body, :text

  timestamps

  validates :user_id, presence: true
  validates :conversation_id, presence: true
  validates :body, presence: true
end
