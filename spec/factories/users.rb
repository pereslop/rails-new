FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    username { Faker::Name.first_name }
    password { Faker::Internet.password}
    factory :user_with_post do
      after(:create) do |user|
        create_list(:post, 10, user: user)
      end
    end
  end

  trait :admin  do
    role :admin
  end
end