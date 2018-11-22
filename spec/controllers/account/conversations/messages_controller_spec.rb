require 'rails_helper'

RSpec.describe Account::Conversations::MessagesController, type: :controller do
  let!(:conversation) { FactoryGirl.create(:conversation) }
  let!(:user) { conversation.users.first }
  let!(:body) { Faker::Lorem.sentence }
  before(:each) { sign_in user }
  describe 'actions' do
    it 'Post#create - invalid' do
      expect do
        post :create, params: { message: { body: '', conversation_id: conversation.id }, conversation_id: conversation.id }
      end.to change(Message, :count).by(0)
    end
    it 'Post#create' do
      expect do
        post :create, params: { message: { body: body, conversation_id: conversation.id }, conversation_id: conversation.id }
      end.to change(Message.all, :count).by(1)
    end
  end
end
