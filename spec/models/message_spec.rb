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
  it { is_expected.to be_mongoid_document }

  let!(:sender) { FactoryGirl.create(:user) }
  let!(:conversation) { FactoryGirl.create(:conversation) }
  # describe 'scope' do
  #   it 'return messages for conversation' do
  #     Message.create(conversation_id: conversation.id, user_id: sender.id)
  #     expect(Message.for_conversation(conversation).count).to eq(1)
  #   end
  # end
end
