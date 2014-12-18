source 'https://rubygems.org'
#source 'https://ruby.taobao.org'

gem 'rails', '4.2.0.rc3'
gem 'pg'

# sass & js
gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'i18n', '~> 0.7.0.beta1'

# json
gem 'jbuilder', '~> 2.0'

# login & auth
gem 'devise', github: 'plataformatec/devise', branch: 'lm-rails-4-2'
gem 'cancancan', '~> 1.9'

# image uploader
gem 'carrierwave'
gem "mini_magick"

# views
gem 'tabletastic', github: 'zlx/tabletastic'
gem 'simple_form'
#gem 'ransack', github: 'activerecord-hackery/ransack', branch: 'rails-4.2'
gem 'ransack', '~> 1.4.1'
gem 'kaminari'
gem 'haml-rails'

# payment
gem 'stripe'

# others
gem 'priceable'
gem 'quiet_assets'
gem 'nested_form_fields'

# preload
group :development do
  gem 'spring'
end

group :test, :development do
  gem 'minitest-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'thin'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry'
  gem 'pry-nav'
  gem 'byebug'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'spork-rails'
  gem 'childprocess'
  gem 'guard-livereload', require: false
  gem 'shoulda-matchers'
end

group :test do
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  #Database Cleaner is a set of strategis for cleaing your database in Ruby
  gem 'database_cleaner',git:'https://github.com/bmabey/database_cleaner.git'  
  gem "poltergeist"
end

