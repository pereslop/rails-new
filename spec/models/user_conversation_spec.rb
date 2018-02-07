require 'rails_helper'

RSpec.describe UserConversation, type: :model do
  let! (:user_conversation) { FactoryGirl.create(:user_conversation) }
  let! (:user) { user_conversation.user }
  let! (:conversation) { user_conversation.conversation }

  describe 'scopes' do
    it 'returns user_conversation for user' do
      expect(described_class.personal_for(conversation, user)).to eq(user_conversation)
    end
  end

  describe 'validations' do
    it 'user_conversation for conversation must be uqiue' do
      UserConversation.new(conversation_id: conversation.id, user_id: user.id).should_not be_valid
    end
  end
end
