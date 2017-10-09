# This file should contain all the record creation needed to seed the database with its default valuese.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

FactoryGirl.create(:user, :with_posts, :admin, email: 'pereslop@gmail.com', password: 'qqqqqq')

FactoryGirl.create_list(:user, 10, :with_posts)

Post.all.each do |post|
  FactoryGirl.create_list(:comment, rand(8..15),
                          user_id: User.pluck(:id).sample,
                          post_id: post.id,
                          created_at: Time.now - rand(11).days)
end
