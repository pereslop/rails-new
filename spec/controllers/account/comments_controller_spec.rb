require 'rails_helper'

RSpec.describe Account::CommentsController, type: :controller do
  context 'Comment' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:post_for_user) { FactoryGirl.create(:post, user: user) }
    let!(:comment) { FactoryGirl.create(:comment, user_id: user.id, post_id: post_for_user.id) }
    before(:each) do
      sign_in user
    end

    describe 'views' do
      it 'get#edit' do
        get :edit, params: { id: comment.id, post_id: post_for_user.id }, xhr: true
        expect(response).to have_http_status(:success)
      end

      it 'get#new' do
        get :new, params: { post_id: post_for_user.id}, xhr: true
        expect(response).to have_http_status(:success)
      end
    end

    describe 'actions' do
      let(:create_action) { post :create, params: { comment: FactoryGirl.attributes_for(:comment), post_id: post_for_user.id }, xhr: true  }
      let(:destroy_action) { delete :destroy, params: { post_id: post_for_user.id, id: comment.id }, xhr: true }

      it 'post#create' do
        expect { create_action }.to change(Comment, :count).by(1)
      end

      it 'patch#update' do
        new_content = 'aaaaaaaaaaaaaaaaaaaaaaa'
        patch :update, params: { post_id: post_for_user.id, id: comment.id, comment: { content: new_content }, xhr: true, format: :js }
        comment.reload
        expect(comment.content).to eq(new_content)
      end

      it 'delete#destroy' do
        expect { destroy_action }.to change(Comment, :count).by(-1)
      end

    end
  end
end