require 'rails_helper'

RSpec.describe Account::Users::SessionsController, type: :controller do

  let!(:user) { FactoryGirl.create(:user) }

  it 'redirect to posts if user is logged' do
    sign_in user
    expect(response).to have_http_status(:success)
  end
end
