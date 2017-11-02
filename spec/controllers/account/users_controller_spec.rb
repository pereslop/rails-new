require 'rails_helper'

RSpec.describe Account::UsersController, type: :controller do

  context "account user routes" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
    end

    it "expect get#index" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      get :show, params: {id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end
