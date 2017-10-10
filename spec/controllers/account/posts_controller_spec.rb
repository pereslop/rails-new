require 'rails_helper'

RSpec.describe Account::PostsController, type: :controller do
  context 'Post actions' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:post) { FactoryGirl.create(:post, user: user) }

    before(:each) do
      sign_in user
    end

    describe "Post views" do
      it 'Get#index' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'Get#show' do
        get :show, params: { id: post.id}
        expect(response.status).to eq(200)
      end
    end

    describe "Post actions" do
      let(:action) { get :toggle_like, params: { id: post.id }, xhr: true }

      it "Get#toggle like" do
        expect { action }.to change { post.likes.count }.by(1)
      end

      it "Delete#destroy" do
        expect do
          delete :destroy, params: { id: post.id }
        end.to change(Post, :count).by(-1)
      end

      it "Post#create" do
        let(:post) {FactoryGirl.create(:post)}
        expect do
         post :create, 
       end.to change(Post, :count).by(1)
      end
    end
  end

end
