class MessageBody
  include Mongoid::Document

  field :body, type: String
  field :message_id, type: String

  validates_presence_of :body, :message_id
  validates_uniqueness_of :message_id

  def self.for_message(message)
    where(message_id: message.id).first
  end
end