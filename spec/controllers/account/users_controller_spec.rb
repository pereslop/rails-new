require 'rails_helper'

RSpec.describe Account::UsersController, type: :controller do
  context 'account user routes' do
    let(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
    end

    it 'expect get#index' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns http success' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    describe 'follow actions' do
      it 'Get#follow' do
        get :follow, params: { id: user2.id }, xhr: true
        expect(response.status).to eq(200)
      end

      it 'Get#unfollow' do
        get :unfollow, params: { id: user2.id }, xhr: true
        expect(response.status).to eq(200)
      end

      it 'Get#followers' do
        get :followers, params: { id: user2.id }, xhr: true
        expect(response.status).to eq(200)
      end

      it 'Get#followees' do
        get :followees, params: { id: user2.id }, xhr: true
        expect(response.status).to eq(200)
      end
    end
  end
end
