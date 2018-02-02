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
    let! (:conversation) { Conversation.create() }
    let! (:recipient) { FactoryGirl.create(:user) }
    let! (:message) do
      FactoryGirl.create(:message, conversation_id: conversation.id, user_id: user.id)
    end
    let! (:unread_message) do
      FactoryGirl.create(:message, conversation_id: conversation.id, user_id: user.id)
    end

    it 'collection includes read message' do
      conversation.users << user
      expect(user.read_messages_for(conversation, Time.now)).to include(message)
    end

    it 'collection includes unread message' do
      conversation.users << user << recipient
      unread_message.update(created_at: Time.now.tomorrow)
      expect(recipient.unread_messages_for(conversation, Time.now).to_a).to include(unread_message)
    end

    it 'user_conversation for user and conversation' do
      conversation.users << user
      expect(user.user_conversation_for(conversation)).to have_attributes(user_id: user.id, conversation_id: conversation.id )
    end
  end
end
