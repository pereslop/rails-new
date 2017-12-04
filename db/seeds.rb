
# This file should contain all the record creation needed to seed the database with its default valuese.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
return unless Rails.env.development?


User.create_with(FactoryGirl.attributes_for(:user, :with_content, :admin, email: 'pereslop@gmail.com', password: 'qqqqqq')).find_or_create_by(role: 'admin')

if User.count < 16
  FactoryGirl.create_list(:user, 15, :with_content)
end

User.all.each do |user|
  User.count.times { user.follow!(User.find(User.pluck(:id).sample))}
end


User.all.each do |user|
  user.messages.create(body: Faker::Lorem.words(5), user_id: User.pluck(:id).sample, conversation_id: Conversation.pluck(:id).sample)
end