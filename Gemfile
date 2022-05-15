# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'sqlite3', '~> 1.4'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 6.0.0.rc1'
  gem 'rubocop', '~> 1.29', require: false
  gem 'rubocop-performance', '~> 1.13', require: false
  gem 'rubocop-rails', '~> 2.14', require: false
  gem 'rubocop-rspec', '~> 2.10', require: false
  gem 'shoulda-matchers', '~> 5.1'
end
