
require 'rails_helper'

RSpec.describe Account::MessagesController, type: :controller do
  let!(:sender) { FactoryGirl.create(:user) }
  let!(:recipient) { FactoryGirl.create(:user) }
  before(:each) do
    sign_in sender
  end

  describe 'POST#create' do
    let(:valid_create_action) do
      post :create, params: {
        message: FactoryGirl.attributes_for(:message,
                                            sender_id: sender.id,
                                            recipient_id: recipient.id)
      }, xhr: true
    end
    let!(:invalid_create_action) do
      post :create,
           params: { message: FactoryGirl.attributes_for(:message).merge(body: '') },
           xhr: true
    end
    it 'valid' do
      expect do
        valid_create_action
        sender.sent_messages.reload
      end.to change(Message, :count).by(1)
    end

    it 'invalid' do
        invalid_create_action
        expect(response.status).to eq(200)
        expect{ invalid_create_action }.to change(Message, :count).by(0)
    end
    describe 'vievs' do
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
