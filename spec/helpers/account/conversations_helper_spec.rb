require 'rails_helper'

RSpec.describe Account::ConversationsHelper, type: :helper do
  let!(:conversation) { Conversation.create() }
  let!(:current_user) { conversation.users.first }
  let!(:recipient) { FactoryGirl.create(:user) }
  let!(:chat_conversation) { FactoryGirl.create(:conversation, kind: :chat, title: Faker::Pokemon.name) }

  it 'returns conversation_title' do
    expect(conversation_name(chat_conversation)).to be(chat_conversation.title)
  end
end
