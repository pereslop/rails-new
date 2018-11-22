require 'rails_helper'

RSpec.describe Account::Conversations::ChatMembersController, type: :controller do
  let!(:conversation) { FactoryGirl.create(:conversation) }
  let!(:user) { conversation.users.first }
  let!(:body) { Faker::Lorem.sentence }

  before(:each) { sign_in user }

  describe 'actions' do
    it 'Get#index' do
      get :index, params: { conversation_id: conversation.id }, xhr: true
      expect(response).to have_http_status(:success)
    end

    it 'Delete#destroy' do
      expect do
        delete :destroy, params: { id: user.id, conversation_id: conversation.id }, xhr: true
      end.to change(conversation.users, :count).by(-1)
    end
  end
end
