require 'rails_helper'

describe User, type: :model do

  context 'User authorization' do
    it 'should create new authorization and user' do
      expect do
        User.from_omniauth(Faker::Omniauth.google, nil)
      end.to change(Authorization, :count).by(1)
    end

    it 'should login user registered user' do
      authorization = FactoryGirl.create(:authorization, :facebook)
      user = authorization.user
      expect(User.from_omniauth(authorization, nil)).to eq(user)
    end
  end

end