
# This file should contain all the record creation needed to seed the database with its default valuese.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
return unless Rails.env.development?

FactoryGirl.create_list(:user, 10, :with_posts)
Post.all.each do |post|
  FactoryGirl.create_list(:comment, rand(5..10),
                          user_id: User.pluck(:id).sample,
                          commentable_type: 'Post',
                          commentable_id: post.id,
                          created_at: Time.now - rand(11).days)
end

Comment.all.each do |comment|
  FactoryGirl.create_list(:comment, rand(5..20),
                          user_id: User.pluck(:id).sample,
                          commentable_type: 'Comment',
                          commentable_id: comment.id)
end