require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  context 'user is not logged' do
    it 'GET #index' do
      get :index
      expect(response.status).to eq(302)
    end
  end

  context 'user logged as user' do
    let!(:user) { FactoryGirl.create(:user) }
    it 'redirect to the root path' do
      sign_in user
      get :index
      expect(response.status).to eq(302)
    end
  end


  context 'user is logged as admin' do
    let!(:admin) { FactoryGirl.create(:user, :admin) }
    let!(:comment) { FactoryGirl.create(:comment, user_id: admin.id)}
    before(:each) do
      sign_in admin
    end
    it 'GET #index' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'GET #show' do
      get :show, params: {id: admin.id }
      expect(response.status).to eq(200)
    end

    it 'Get #statists'do
      get :statistic, params: { id: User.all.pluck(:id).sample }, xhr: true
      expect(response.status).to eq(200)
    end

    it 'GET #edit' do
      get :edit, params: {id: admin.id }
      expect(response.status).to eq(200)
    end

    it 'DELETE #destroy' do
      expect{ delete :destroy, params: { id: admin.id } }.to change(User, :count).by(-1)
    end

    it  'Patch #update' do
      new_name = Faker::Name.first_name
      patch :update, params: { id: admin.id, user: { username: new_name } }
      expect(admin.reload.username).to eq(new_name)
      expect(response.status).to eq(302)
    end

    it 'patch#update failed' do
      new_name = 'q'
      patch :update, params: { id: admin.id, user: { username: new_name } }
      expect(response.status).to eq(200)
    end
  end
end
