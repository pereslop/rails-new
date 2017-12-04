require 'rails_helper'

describe User, type: :model do
  let! (:auth) { Faker::Omniauth.facebook }
  let! (:user) { FactoryGirl.create(:user)}
  let! (:authorization) { FactoryGirl.create(:authorization) }

  describe 'User authorization' do
    it 'create new authorization and user' do
      expect do
        described_class.from_omniauth(auth)
      end.to change(Authorization, :count).by(1).and change(described_class, :count).by(1)
    end

    it 'login registered user with authorization' do

      expect do
        described_class.from_omniauth(authorization)
      end.to change(described_class, :count).by(0)
    end

    it 'login user without authorization' do
      auth[:info][:email] = user.email
      expect do
        described_class.from_omniauth(auth)
      end.to  change(described_class, :count).by(0).and change(Authorization, :count).by(1)
    end
  end

end
