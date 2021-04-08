source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise', '4.7.1'
gem 'devise-async', '>= 1.0.0'
gem 'devise_invitable', '2.0.1'
gem 'faker', '>= 2.1.2'
gem 'jbuilder', git: 'https://github.com/rails/jbuilder', branch: 'master'
gem 'octicons_helper'
gem 'pg', '1.2.2'
gem 'puma', '~> 4.3'
gem 'rails', '6.0.0'
gem 'sass-rails', '~> 6.0'
gem 'sidekiq', '5.2.7'
gem 'simple_form', '>=4.1.0'
gem 'turbolinks', '~> 5'
gem 'webpacker', '>= 4.0.0.rc.3'
gem 'webpacker-react', '~> 1.0.0.beta.1'

group :development, :test do
  gem 'binding_of_caller'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails', '2.7.6', require: false
  gem 'email_spec'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'letter_opener'
  gem 'minitest-reporters'
  gem 'rspec-rails', '~>3.9'
  gem 'rubocop', '>= 0.79.0'
end

group :development do
  gem 'better_errors'
  gem 'bullet'
  gem 'guard', '>= 2.15.0', require: false
  gem 'guard-bundler', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner'
  gem 'minitest-around'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', '>= 0.16.1', require: false
  gem 'webdrivers'
end
