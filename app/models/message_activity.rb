class MessageActivity
  include Mongoid::Document

  field :user_id, type: Integer
  field :read_messages_count, type: Integer
  field :unread_messages_count, type: Integer
end
