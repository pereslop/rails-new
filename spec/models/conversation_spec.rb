# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Conversation, type: :model do
 let!(:sender) { FactoryGirl.create(:user) }
 let!(:recipient) { FactoryGirl.create(:user) }
 let!(:conversation) { Conversation.create() }

 describe 'scopes' do
   it 'return conversation between users' do
     conversation.users << sender << recipient
     expect(described_class.between_users([sender.id, recipient.id]).first.id).to eq(conversation.id)
   end
 end
end
