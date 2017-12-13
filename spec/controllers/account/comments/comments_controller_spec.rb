require 'rails_helper'

RSpec.describe Account::Comments::CommentsController, type: :controller do
  context 'Comment' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:post_for_user) { FactoryGirl.create(:post, user: user) }
    let!(:post_comment) { FactoryGirl.create(:comment, user_id: user.id, commentable: post_for_user) }
    let!(:nested_comment) { FactoryGirl.create(:comment, user_id: user.id, commentable: post_comment) }
    before(:each) do
      sign_in user
    end

    describe 'views' do
      it 'get#index' do
        get :index,  params: { comment_id: post_comment.id }, xhr: true
        expect(response).to have_http_status(:success)
      end

      it 'get#edit' do
        get :edit, params: { id: nested_comment.id, comment_id: post_comment.id }, xhr: true
        expect(response).to have_http_status(:success)
      end

      it 'get#new' do
        get :new, params: { comment_id: post_comment.id }, xhr: true
        expect(response).to have_http_status(:success)
      end
    end

    describe 'actions' do
      let(:create_action) { post :create, params: { comment: FactoryGirl.attributes_for(:comment), comment_id: post_comment.id }, xhr: true  }
      let(:destroy_action) { delete :destroy, params: { comment_id: post_comment.id, id: nested_comment.id }, xhr: true }

      it 'post#create' do
        expect { create_action }.to change(Comment, :count).by(1)
      end

      it 'patch#update' do
        new_content = 'aaaaaaaaaaaaaaaaaaaaaaa'
        patch :update, params: { comment: { content: new_content }, comment_id: post_comment.id, id: nested_comment.id,  xhr: true, format: :js }
        nested_comment.reload
        expect(nested_comment.content).to eq(new_content)
      end

      it 'delete#destroy' do
        expect { destroy_action }.to change(Comment, :count).by(-1)
      end
    end
  end
end