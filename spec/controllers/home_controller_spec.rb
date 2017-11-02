require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context 'home_controller routes' do
    let!(:user) { FactoryGirl.create(:user) }
    it 'redirect to posts if user is logged' do
      sign_in user

      get :index
      expect(response).to have_http_status(302)
    end

    it 'render home#index' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
