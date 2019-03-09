source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'jbuilder', git: 'https://github.com/rails/jbuilder', branch: 'master'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 6.0.0.beta1'
gem 'sass-rails', '~> 5.0'
gem 'simple_form', '>=4.1.0'
gem 'turbolinks', '~> 5'
gem 'webpacker', '>= 4.0.0.rc.3'

group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker', '>= 1.9.3'
  gem 'minitest-reporters'
  gem 'rubocop', '>= 0.65.0'
end

group :development do
  gem 'guard', '>= 2.15.0', require: false
  gem 'guard-bundler', require: false
  gem 'guard-livereload', require: false
  gem 'guard-minitest', require: false
  gem 'guard-rails', require: false
  gem 'guard-rubocop', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'minitest-around'
  gem 'selenium-webdriver'
  gem 'simplecov', '>= 0.16.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
