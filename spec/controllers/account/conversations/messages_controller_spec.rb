
require 'rails_helper'

RSpec.describe Account::Conversations::MessagesController, type: :controller do
  let!(:conversation) { FactoryGirl.create(:conversation) }
  let!(:user) { conversation.users.first }
  let!(:body) { Faker::Lorem.sentence }
  before(:each) { sign_in user }
  describe 'actions' do
    it 'Post#create' do
      post :create, params: { message_body: { body: body, conversation_id: conversation.id }, conversation_id: conversation.id }
      expect(Message.all.to_a.count).to eq(1)
    end
    it 'Post#create - invalid' do
      post :create, params: { message_body: { body: '', conversation_id: conversation.id }, conversation_id: conversation.id }
      expect(Message.all.to_a.count).to eq(0)
    end
  end
end
