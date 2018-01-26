FactoryGirl.define do
    factory :conversation do
    title { Faker::LeagueOfLegends.champion }
    users { |a| [a.association(:user)] }
    end
end
