source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'faker', '>= 2.1.2'
gem 'jbuilder', git: 'https://github.com/rails/jbuilder', branch: 'master'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.0.rc2'
gem 'sass-rails', '~> 5.0'
gem 'simple_form', '>=4.1.0'
gem 'turbolinks', '~> 5'
gem 'webpacker', '>= 4.0.0.rc.3'
gem 'webpacker-react', "~> 1.0.0.beta.1"

group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'minitest-reporters'
  gem 'rspec-rails', '~>3.5'
  gem 'rubocop', '>= 0.65.0'
end

group :development do
  gem 'guard', '>= 2.15.0', require: false
  gem 'guard-bundler', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
  gem 'database_cleaner'
  gem 'minitest-around'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', '>= 0.16.1'
end
