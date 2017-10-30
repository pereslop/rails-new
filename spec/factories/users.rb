# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer          default("user")
#  username               :string
#  avatar                 :string
#

FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    username { Faker::Pokemon.name }
    password { Faker::Internet.password(8) }
    avatar { Faker::Avatar.image("my-own-slug")}
  end

  trait :with_posts do
    after(:create) do |user|
      create_list(:post, 5, user: user)
    end

    after(:build) do |user|
      build_list(:post, 5, user: user)
    end
  end

  trait :admin  do
    role :admin
  end
end
