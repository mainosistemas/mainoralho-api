source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"
gem "api-pagination"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.4", require: false
gem "rails", "~> 7.0.0.alpha2"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem 'pry', '~> 0.13.1'
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "rack-cors"
gem "jwt"
gem "will_paginate"

group :development, :test do
  gem "debug", ">= 1.0.0", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 5.0.0"
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
