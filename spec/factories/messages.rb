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

FactoryGirl.define do
  factory :message do
    body { Faker::Matz.quote }
  end
end