
# This file should contain all the record creation needed to seed the database with its default valuese.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
return unless Rails.env.development?

if User.count < 16
  User.create_with(FactoryGirl.attributes_for(:user,
                                              :with_content,
                                              :admin)).find_or_create_by(role: 'admin')
  FactoryGirl.create_list(:user, 15)
end

users_ids = User.all.pluck(:id)

User.all.each do |user|
  users_collection = User.all.without(user)
  User.count.times { user.follow!(users_collection.sample) }
  users_collection.each do |recipient|
    conversation = user.conversations.create()
    conversation.messages.create(body: Faker::Lorem.sentence, user_id: user.id)

    conversation.users << recipient
    conversation.messages.create(body: Faker::Lorem.sentence, user_id: recipient.id )
  end
end
