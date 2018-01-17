class MessageBody
  include Mongoid::Document

  field :body, type: String
  field :message_id, type: Integer
  field :sender_id, type: Integer

  set_created_at

  validates_presence_of :body, :message_id, :sender_id

end