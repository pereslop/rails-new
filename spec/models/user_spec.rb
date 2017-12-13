# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer          default("user,")
#  username               :string
#  avatar                 :string
#  followees_count        :integer          default(0)
#  followers_count        :integer          default(0)
#

require 'rails_helper'

describe User, type: :model do
  let! (:auth) { Faker::Omniauth.facebook }
  let! (:user) { FactoryGirl.create(:user)}
  let! (:authorization) { FactoryGirl.create(:authorization) }

  context 'validations' do
    it { FactoryGirl.build(:user).should be_valid }
  end

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

  describe 'user scopes' do

  end
end
