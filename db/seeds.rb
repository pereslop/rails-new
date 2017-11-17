
# This file should contain all the record creation needed to seed the database with its default valuese.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
return unless Rails.env.development?

unless User.find_by(role: 'admin')
  User.create(FactoryGirl.attributes_for(:user, :with_content, :admin, email: 'pereslop@gmail.com', password: 'qqqqqq'))
end
User.create_with(FactoryGirl.attributes_for(:user, :with_content, :admin, email: 'pereslop@gmail.com', password: 'qqqqqq')).find_or_create_by(email: 'pereslop@gmail.com')
if User.count < 10
  FactoryGirl.create_list(:user, 5, :with_content)
end

User.all.each do |user|
  User.count.times { user.follow!(User.find(User.pluck(:id).sample))}
end