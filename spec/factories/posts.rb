FactoryGirl.define do
  factory :post do
    content { Faker::Lorem.sentence(5) }
  end
end
