class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :conversation_id, type: Integer
  field :user_id, type: Integer

  scope :for_conversation, ->(conversation) { where(conversation_id: conversation.id) }
  scope :created_after, ->(start_time) { where(:created_at.gte => start_time) }
  scope :created_in, ->(day) { where(created_at: day.midnight..day.end_of_day) }

  validates_presence_of :body, :user_id, :conversation_id
  validates :body, length: { maximum: 120 }

  def self.last_for_conversation(conversation)
      for_conversation(conversation).asc(:created_at).last
  end

  def self.last_created_at
    asc(:created_at).last
  end

  def self.count_for_day

  end
end