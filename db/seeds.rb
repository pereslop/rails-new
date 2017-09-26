# This file should contain all the record creation needed to seed the database with its default valuese.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

FactoryGirl.create(:user_with_post, :admin, email: 'pereslop@gmail.com', password: 'qqqqqq')
FactoryGirl.create(:user_with_post, email: 'kvas@gmail.com', password: 'qqqqqq')
FactoryGirl.create_list(:user_with_post, 99)