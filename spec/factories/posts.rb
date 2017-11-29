# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  content      :text
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  picture      :string
#  likers_count :integer          default(0)
#  likees_count :integer          default(0)
#

FactoryGirl.define do
  factory :post do
    content { Faker::Lorem.sentence(5) }
    picture { Rack::Test::UploadedFile.new(Dir[Rails.root.join('spec', 'support', 'images', 'posts_pictures', '*.*')].sample) }
  end
end
