# == Schema Information
#
# Table name: user_conversations
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  conversation_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user_conversation do
    
  end
end
