class MessageBody
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :body, type: String
  field :message_id, type: String
  field :conversation_id, type: Integer
  field :user_id, type: Integer

  scope :for_conversation, ->(conversation) { where(conversation_id: conversation.id) }
  scope :created_after, ->(start_time) { where(:created_at.gte => start_time) }

  validates_presence_of :body, :message_id, :user_id, :conversation_id
  validates_uniqueness_of :message_id
  validates :body, length: { maximum: 20 }

  def self.last_for_conversation(conversation)
      for_conversation(conversation).asc(:created_at).last
  end

  def self.for_message(message)
    where(message_id: message.id).first
  end
end