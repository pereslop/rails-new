require 'rails_helper'

RSpec.describe Account::Posts::CommentsController, type: :controller do
  context 'Comment' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:post_for_user) { FactoryGirl.create(:post, user: user) }
    let!(:post_comment) { FactoryGirl.create(:comment, user_id: user.id, commentable: post_for_user) }
    before(:each) do
      sign_in user
    end

    describe 'views' do
      it 'get#index' do
        get :index,  params: { post_id: post_for_user.id }, xhr: true
        expect(response).to have_http_status(:success)
      end

      it 'get#edit' do
        get :edit, params: { id: post_comment.id, post_id: post_for_user.id }, xhr: true
        expect(response).to have_http_status(:success)
      end

      it 'get#new' do
        get :new, params: { post_id: post_for_user.id }, xhr: true
        expect(response).to have_http_status(:success)
      end
    end

    describe 'actions' do
      let(:create_action) { post :create, params: { comment: FactoryGirl.attributes_for(:comment), post_id: post_for_user.id }, xhr: true  }
      let(:destroy_action) { delete :destroy, params: { post_id: post_for_user.id, id: post_comment.id }, xhr: true }

      it 'post#create' do
        expect { create_action }.to change(Comment, :count).by(1)
      end

      it 'patch#update' do
        new_content = 'aaaaaaaaaaaaaaaaaaaaaaa'
        patch :update, params: { comment: { content: new_content }, post_id: post_for_user.id, id: post_comment.id,  xhr: true, format: :js }
        post_comment.reload
        expect(post_comment.content).to eq(new_content)
      end

      it 'delete#destroy' do
        expect { destroy_action }.to change(Comment, :count).by_at_least(-1)
      end
    end
  end
end