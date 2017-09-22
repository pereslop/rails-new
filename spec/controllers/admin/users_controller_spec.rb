require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  context 'user is not logged' do
    it 'GET #index' do
      get :index
      expect(response.status).to eq(302)
    end

    it 'GET #new' do
      get :new
      expect(response.status).to eq(302)
    end
  end

  context 'user is logged as admin' do

    user = FactoryGirl.create(:user)
    sign_in user

    it 'GET #index' do
      get :index
      expect(response.status).to eq(302)
    end

    it 'GET #new' do
      get :new
      expect(response.status).to eq(302)
    end
  end
end
