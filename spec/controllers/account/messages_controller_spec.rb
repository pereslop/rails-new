require 'rails_helper'

RSpec.describe Account::MessagesController, type: :controller do
  let!(:sender) { FactoryGirl.create(:user) }
  let!(:recipient) { FactoryGirl.create(:user) }
  before(:each) do
    sign_in sender
  end

  describe 'actions' do
    let!(:create_action) do
      post :create, params: {
        message: FactoryGirl.attributes_for(:message, recipient_id: recipient.id)
      }
    end
    it 'POST#create' do
      expect { create_action }.to change(Message, :count).by(1)
    end
  end
end
