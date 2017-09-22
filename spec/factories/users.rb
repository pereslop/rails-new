FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    username { Faker::Name.first_name }
    password { Devise.friendly_token.first(8) }
    role 'user'
  end
end