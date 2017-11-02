require 'rails_helper'

RSpec.describe Account::PostsController, type: :controller do
  context 'Post' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:post_for_user) { FactoryGirl.create(:post, user: user) }
    let!(:content) { Faker::Lorem.sentence(5) }

    before(:each) do
      sign_in user
    end

    describe 'views' do
      it 'Get#index' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'Get#show' do
        get :show, params: { id: post_for_user.id}, xhr: true
        expect(response.status).to eq(200)
      end

      it 'Get#edit' do
        get :edit, params: { id: post_for_user.id}, xhr: true
        expect(response.status).to eq(200)
      end
    end

    describe 'actions' do
      let(:toggle_like_action) { get :toggle_like, params: { id: post_for_user.id }, xhr: true }
      let(:create_action) { post :create, params: { post: FactoryGirl.attributes_for(:post)} }
      it 'Get#toggle like' do
        expect { toggle_like_action }.to change { post_for_user.likes.count }.by(1)
      end

      it 'Post#update' do
        patch :update,params: { id: post_for_user.id, post: { content: content } , xhr: true, format: :js }
        post_for_user.reload
      end


      it 'Delete#destroy' do
        expect do
          delete :destroy, params: { id: post_for_user .id }, xhr: true
        end.to change(Post, :count).by(-1)
      end

      it 'Post#create' do
        expect { create_action }.to change(Post, :count).by(1)
      end

    end
  end
end
