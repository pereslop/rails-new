FactoryGirl.define do
    factory :conversation do
    title { Faker::Lorem.sentence }
    users { |a| [a.association(:user)] }
    end
end
