class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :body, type: String
  field :conversation_id, type: Integer
  field :user_id, type: Integer

  scope :for_conversation, ->(conversation) { where(conversation_id: conversation.id) }
  scope :created_after, ->(start_time) { where(:created_at.gte => start_time) }

  validates_presence_of :body, :user_id, :conversation_id
  validates :body, length: { maximum: 20 }

  def self.last_for_conversation(conversation)
      for_conversation(conversation).asc(:created_at).last
  end

end