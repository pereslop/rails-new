require 'rails_helper'

RSpec.describe Account::Users::PostsController, type: :controller do
  context 'Post' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:post_for_user) { FactoryGirl.create(:post, user: user) }

    before(:each) do
      sign_in user
    end

    it 'Get#show' do
      get :show, params: {  user_id: user.id, id: post_for_user.id }, xhr: true
      expect(response.status).to eq(200)
    end

    it 'Delete#destroy' do
      expect do
        delete :destroy, params: { user_id: user.id, id: post_for_user.id }, xhr: true
      end.to change(Post, :count).by(-1)
    end
  end
end
