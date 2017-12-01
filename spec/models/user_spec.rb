require 'rails_helper'

describe User, type: :model do

  describe 'User authorization' do
    it 'create new authorization and user' do
      expect do
        described_class.from_omniauth(Faker::Omniauth.facebook)
      end.to change(Authorization, :count).by(1).and change(described_class, :count).by(1)
    end

    it 'login registered user with authorization' do
      authorization = FactoryGirl.create(:authorization)
      user = authorization.user
      expect do
        described_class.from_omniauth(authorization)
      end.to change(described_class, :count).by(0)
    end

    it 'login user without authorization' do
      user = FactoryGirl.create(:user)
      authorization = Faker::Omniauth.facebook
      authorization[:info][:email] = user.email
      expect do
        described_class.from_omniauth(authorization)
      end.to  change(described_class, :count).by(0).and change(Authorization, :count).by(1)
    end
  end

end