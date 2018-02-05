class MessageActivity
  include Mongoid::Document

  field :user_id, type: Integer
  field :read_messages_count, type: Integer
  field :unread_messages_count, type: Integer

  validates_presence_of :user_id, :read_messages_count, :unread_messages_count
end
