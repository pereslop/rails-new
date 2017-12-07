
# This file should contain all the record creation needed to seed the database with its default valuese.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
return unless Rails.env.development?

User.create_with(FactoryGirl.attributes_for(:user,
                                            :with_content,
                                            :admin,
                                            password: 'qqqqqq')).find_or_create_by(role: 'admin')
FactoryGirl.create_list(:user, 15, :with_content) if User.count < 16

users_ids = User.all.pluck(:id)
User.all.each do |user|
  User.count.times { user.follow!(User.find(users_ids.sample))}
  20.times { FactoryGirl.create(:message, sender_id: user.id, recipient_id: users_ids.sample) }
end
