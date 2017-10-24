# == Schema Information
#
# Table name: comments
#
#  id              :integer          not null, primary key
#  content         :text
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  comentable_type :string
#  comentable_id   :integer
#

FactoryGirl.define do
  factory :comment do
    content  { Faker::Lorem.sentence(5) }
    association :user
  end

  trait :with_comments do
    after(:create) do |comment|
      create_list(:comment, 6, commentable: comment)
    end

    after(:build) do |comment|
      build_list(:comment, 6, commentable: comment)
    end  end
end
