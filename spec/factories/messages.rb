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

FactoryGirl.define do
    factory :message do
    body { Faker::Lorem.sentence }
    association :sender, factory: :user
    association :recipient, factory: :user
    end
end
