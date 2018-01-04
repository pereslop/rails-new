require 'rails_helper'

RSpec.describe Account::ConversationsController, type: :controller do
  let!(:sender) { FactoryGirl.create(:user) }
  let!(:recipient) { FactoryGirl.create(:user) }
  let!(:new_recipient) { FactoryGirl.create(:user) }
  let!(:conversation) { Conversation.create() }

  before(:each) do
    conversation.users << sender << recipient
    sign_in sender
  end

  describe 'actions' do
    it 'Get#index' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'Get#chat' do
      get :chat, params: { id: conversation.id }, xhr: true
      expect(response).to have_http_status(:success)
    end
    it 'Get#recipient without common conversation' do
      get :recipient, params: { id: new_recipient.id }
      expect(response).to have_http_status(:success)
    end
    it 'Get#recipient with common conversation' do
      get :recipient, params: { id: recipient.id }
      expect(response).to have_http_status(:success)
    end
  end
end
