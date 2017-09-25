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
    let(:admin) { FactoryGirl.create(:admin) }
    before(:each) do
      sign_in admin
    end
    it 'GET #index' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'GET #new' do
      get :new
      expect(response.status).to eq(200)
    end

  end

  context 'admin can destroy' do
    let(:user) { FactoryGirl.create(:admin) }
    before(:each) do
      sign_in user
      delete :destroy, params: {id: user.id}
    end

    it 'success' do
      expect{user.destroy}.to change(User, :count).by(0)
    end
    it 'shoold redirect root' do
      expect redirect_to root_path
    end
  end

  context 'admin can edit' do


  end
end
