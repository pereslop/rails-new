# This file should contain all the record creation needed to seed the database with its default valuese.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.create!([{
                 username: 'alinka',
                 email: 'alinka@gmail.com',
                 role: 'admin',
                 password: 'qqqqqq',
                 password_confirmation: 'qqqqqq'
             }])


99.times do |n|
  username =  Faker::Name.first_name
  email = "#{username}@gmail.com"
  role = 'user'
  password =  'qqqqqq'
  User.create!(
      username: username,
      email: email,
      role: role,
      password: password,
      password_confirmation: password
  )
end