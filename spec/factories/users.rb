FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    username { Faker::Name.first_name }
    password { Faker::Internet.password}
  end

  trait :admin  do
    role :admin
  end
end