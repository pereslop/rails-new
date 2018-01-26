source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.4.1'

gem 'activemodel-serializers-xml'
gem 'bootstrap-sass', '3.3.7'
gem 'carrierwave', '~> 1.0'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'devise-bootstrap-views'
gem 'faker', :git => 'git://github.com/stympy/faker.git', :branch => 'master'
gem 'figaro'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'kaminari'
gem 'mini_magick'
gem 'mongoid'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'pry-byebug'
gem 'premailer-rails'
gem 'rails', '~> 5.1.4'
gem 'rails-backbone'
gem 'ransack'
gem 'rmagick'
gem 'rubyvis'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'skim'
gem 'slim-rails'
gem 'socialization'
gem 'uglifier', '>= 1.3.0'



group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.6'
  gem 'rspec-html-matchers'
  gem 'database_cleaner'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'mongoid-rspec'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'any_login'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
