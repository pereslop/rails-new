# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :authorization do
    association :user
    provider { Faker::Omniauth.facebook[:provider] }
    uid { Faker::Omniauth.facebook[:uid] }
  end

end
