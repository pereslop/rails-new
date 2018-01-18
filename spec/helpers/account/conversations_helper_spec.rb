require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the Account::UsersHelper. For example:
#
# describe Account::UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe Account::ConversationsHelper, type: :helper do
  let!(:conversation) { FactoryGirl.create(:conversation) }
  let!(:current_user) { conversation.users.first }
  let!(:recipient) { FactoryGirl.create(:user) }
  let!(:message) { Message.create(conversation_id: conversation.id, user_id: conversation.users.first.id) }
  let!(:message_body) { MessageBody.create(message_id: message.id, body: Faker::Lorem.sentence) }


  it 'get collection with users for conversation without current_user' do
    conversation.users << recipient
    expect(conversations_users(conversation)).not_to include(current_user)
  end

  it 'returns message body for message' do
    expect(message_text(message)).to eq(message_body.body)
  end
end
