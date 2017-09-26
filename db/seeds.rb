# This file should contain all the record creation needed to seed the database with its default valuese.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

FactoryGirl.create(:user, :admin, email: 'pereslop@gmail.com', password: 'qqqqqq')

FactoryGirl.create_list(:user, 99)