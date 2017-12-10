# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  body         :text
#  sender_id    :integer
#  recipient_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Message, type: :model do
  let!(:sender) { FactoryGirl.create(:user) }
  let!(:recipient) { FactoryGirl.create(:user) }
  let!(:new_companion) { FactoryGirl.create(:user) }

  describe 'User validation' do
    it 'sender can not sent message himself' do
      expect(FactoryGirl.build(:message,
        sender_id: sender.id,
        recipient_id: sender.id).valid?).to be_falsey
    end
  end

  describe 'Users scopes' do
    it 'select all messases for user(whrere he is recipient, or sender)' do
      FactoryGirl.create(:message, sender_id: sender.id, recipient_id: recipient.id)
      FactoryGirl.create(:message, sender_id: recipient.id, recipient_id: sender.id)

      expect(described_class.all_for_user(sender).count).to eq(2)
    end

    it 'select all messases for user(whrere he is recipient, or sender)' do
      FactoryGirl.create(:message, sender_id: sender.id, recipient_id: recipient.id)
      FactoryGirl.create(:message, sender_id: recipient.id, recipient_id: sender.id)
      FactoryGirl.create(:message, sender_id: recipient.id, recipient_id: new_companion.id)

      expect(described_class.between_users(sender, recipient).count).to eq(2)
      expect(described_class.between_users(new_companion, recipient).count).to eq(1)
      expect(described_class.between_users(sender, sender).count).to eq(0)
    end

  end
end
