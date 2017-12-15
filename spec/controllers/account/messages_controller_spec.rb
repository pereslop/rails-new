
require 'rails_helper'

RSpec.describe Account::MessagesController, type: :controller do
  let!(:sender) { FactoryGirl.create(:user) }
  let!(:recipient) { FactoryGirl.create(:user) }
  before(:each) do
    sign_in sender
  end

  describe 'POST#create' do
    it 'valid' do
      expect do
        post :create, params: {
            message: FactoryGirl.attributes_for(:message,
                                                sender_id: sender.id,
                                                recipient_id: recipient.id)
        }, xhr: true
        sender.sent_messages.reload
      end.to change(Message, :count).by(1)
    end

    it 'invalid' do
      expect do
        post :create, params: {
            message: FactoryGirl.attributes_for(:message,
                                                sender_id: sender.id,
                                                recipient_id: recipient.id).merge(body: '')
        }, xhr: true
        end.to change(Message, :count).by(0)
    end

    describe 'views' do
      let!(:message) { FactoryGirl.create(:message, sender_id: sender.id) }

      it 'MESSAGES#index' do
        get :index
        expect(response.status).to eq(302)
      end

      it 'MESSAGES#chat' do
        get :chat, params: { id: message.recipient.id}
        expect(response.status).to eq(200)
      end
      it 'MESSAGES#chat/AJAX' do
        get :chat, params: { id: message.recipient.id}, xhr: true
        expect(response.status).to eq(200)
      end
    end
  end
end
