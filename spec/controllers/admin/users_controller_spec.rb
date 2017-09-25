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

    it 'GET #show' do
      get :index, params: {id: admin.id }
      expect(response.status).to eq(200)
    end

    it 'GET #edit' do
      get :index, params: {id: admin.id }
      expect(response.status).to eq(200)
    end

    it 'GET #new' do
      get :new
      expect(response.status).to eq(200)
    end
    it 'DELETE #destroy' do

      expect{ delete :destroy, params: { id: admin.id } }.to change(User, :count).by(-1)
    end

    it 'POST #create' do
      expect do
        post :create, params: { user: FactoryGirl.attributes_for(:user) }
      end.to change(User, :count).by(1)
    end

    it  'Patch #update' do
      new_name = Faker::Name.first_name
      patch :update, params: { id: admin.id, user: { username: new_name } }
      expect(admin.reload.username).to eq(new_name)
      expect(response).to have_http_status(302)
    end
  end
end
