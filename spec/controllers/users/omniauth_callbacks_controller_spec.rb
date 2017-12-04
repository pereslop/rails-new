require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  let(:default_email) { 'pereslop@rere.com' }
  let(:user) { User.find_by(email: default_email)}


  describe 'GET#ALL' do

    it 'creates new user with valid response' do
      expect do
        setup_env_for_omniauth
        get :all
      end.to change(User, :count).by(1)
    end

    it 'with invalid response' do
      expect do
        setup_env_for_omniauth(false)
        get :all
      end.to change(User, :count).by(0)
    end

    it 'login authorized user' do
      FactoryGirl.create(:user, email: default_email)
      expect do
        setup_env_for_omniauth
        get :all
      end.to change(User, :count).by(0)
    end

  end

  def setup_env_for_omniauth(email = true)
    request.env['devise.mapping'] = Devise.mappings[:user]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = env_data_for_facebook(email)

    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
  end

  def env_data_for_facebook(email)
    @facebook_hash = Faker::Omniauth.facebook
    if email
      @facebook_hash[:info][:email] = default_email
    else
      @facebook_hash[:info][:email] = ''
    end
    @facebook_hash
  end
end
