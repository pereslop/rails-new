FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    username { Faker::Name.first_name }
    role 'user'
    password 'qqqqqq'
    password_confirmation 'qqqqqq'
  end

  factory :admin, class: User do
    email { Faker::Internet.email }
    username { Faker::Name.first_name }
    role 'admin'
    password 'qqqqqq'
    password_confirmation 'qqqqqq'
  end
end