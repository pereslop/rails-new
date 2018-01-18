require 'rails_helper'

RSpec.describe MessageBody, type: :model do
  let!(:conversation) { FactoryGirl.create(:conversation) }
  let!(:message) { Message.create(conversation_id: conversation.id, user_id: conversation.users.first.id) }
  let!(:message_body) { MessageBody.create(message_id: message.id, body: Faker::Lorem.sentence) }

  it 'returns MessageBody for Message' do
    expect(MessageBody.for_message(message)).to eq(message_body)
  end
end
