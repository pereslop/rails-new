class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :conversation_id, type: Integer
  field :user_id, type: Integer

  scope :for_conversation, ->(conversation) { where(conversation_id: conversation.id) }
  scope :created_after, ->(start_time) { where(:created_at.gte => start_time) }
  scope :created_before, ->(start_time) { where(:created_at.lt => start_time) }
  scope :created_in, ->(day) { where(created_at: day.midnight..day.end_of_day) }
  scope :created_between, ->(start_time, end_time) { where( created_at: start_time..end_time) }

  validates_presence_of :body, :user_id, :conversation_id
  validates :body, length: { maximum: 120 }

end