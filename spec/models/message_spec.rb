# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  body            :text
#  conversation_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Message, type: :model do
  let!(:sender) { FactoryGirl.create(:user) }
  let!(:conversation) { FactoryGirl.create(:conversation) }
  describe 'scope' do
    it 'return messages for conversation' do
      Message.create(conversation_id: conversation.id, user_id: sender.id, body: Faker::Lorem.sentence  )
      expect(Message.for_conversation.count).to eq(1)
    end
  end
end
