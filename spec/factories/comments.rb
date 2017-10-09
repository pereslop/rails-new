FactoryGirl.define do
  factory :comment do
    content  { Faker::Lorem.sentence(5) }
    association :post
    association :user
  end
end
