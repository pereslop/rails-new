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

    context 'comment actions' do
      let!(:invalid_content ) { '' }
      let!(:valid_content) {  Faker::Lorem.sentence(5) }
      describe '#create' do
        it 'create new comment' do
          expect do
            post :create, params: { comment: { content: valid_content }, post_id: post_for_user.id }, xhr: true
          end.to change(Comment, :count).by(1)
        end
        it 'does not create comment' do
          expect do
            post :create, params: {  comment: { content: invalid_content }, post_id: post_for_user.id, xhr: true }
          end.to change(Comment, :count).by(0)
        end
      end

      describe '#update' do
        it 'change comment content' do
          patch :update, params: { comment: { content: valid_content }, post_id: post_for_user.id, id: post_comment.id,  xhr: true, format: :js }
          post_comment.reload
          expect(post_comment.content).to eq(valid_content)
        end

        it 'does not change comment content' do
          patch :update, params: { comment: { content: invalid_content }, post_id: post_for_user.id, id: post_comment.id,  xhr: true, format: :js }
          post_comment.reload
          expect(post_comment.content).to eq(post_comment.content)
        end
      end
      describe '#destroy' do
        it 'delete comment from database' do
          expect do
            delete :destroy, params: { post_id: post_for_user.id, id: post_comment.id }, xhr: true
          end.to change(Comment, :count).by(-1)
        end
      end
    end
  end
end