# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_type :string
#  commentable_id   :integer
#

FactoryGirl.define do
  factory :comment do
    content  { Faker::Lorem.sentence(5) }
    association :user
  end
end
