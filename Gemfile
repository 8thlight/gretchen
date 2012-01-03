source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'sqlite3', :group => :development
gem 'jquery-rails', :group => :development
gem 'omniauth'
gem 'omniauth-google-oauth2', :git => 'git://github.com/zquestz/omniauth-google-oauth2.git'
gem "google-api-client", "~> 0.3.0"
gem 'mail'

group :test, :development do
  gem "rspec-rails", "~> 2.7.0"
  gem 'capybara'
  gem 'jasmine'
  gem 'webrat'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'turn', '0.8.2', :require => false
  gem 'launchy'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :production do
  gem 'pg'
end
