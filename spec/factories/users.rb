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
#  role                   :integer          default("user,")
#  username               :string
#  avatar                 :string
#  followees_count        :integer          default(0)
#  followers_count        :integer          default(0)
#

FactoryGirl.define do


  factory :user do
    email { Faker::Internet.email }
    username { Faker::Name.name }
    password { Faker::Internet.password(8) }
    avatar { Rack::Test::UploadedFile.new(Dir[Rails.root.join('spec', 'support', 'images', 'users_avatars', '*.*')].sample) }
  end

  trait :with_content do
    after(:create) do |user|
      posts = create_list(:post, 5, user: user)
      posts.each do |post|
        comments = FactoryGirl.create_list(:comment, rand(5..10),
                                      user_id: User.pluck(:id).sample,
                                      commentable_type: 'Post',
                                      commentable_id: post.id,
                                      created_at: Time.now - rand(11).days)
        comments.each do |comment|
            FactoryGirl.create_list(:comment, rand(5..20),
                                    user_id: User.pluck(:id).sample,
                                    commentable_type: 'Comment',
                                    commentable_id: comment.id)
        end
      end
    end
  end

  trait :admin  do
    role :admin
    email 'pereslop@gmail.com'
    password 'qqqqqq'
  end
end
