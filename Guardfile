guard 'livereload' do
    watch(%r{app/.+\.(erb|haml)})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{public/.+\.(css|js|html)})
    watch(%r{config/locales/.+\.yml})
end

guard :bundler do
    require 'guard/bundler'
    require 'guard/bundler/verify'
    helper = Guard::Bundler::Verify.new

    files = ['Gemfile']
    files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

    # Assume files are symlinked from somewhere
    files.each { |file| watch(helper.real_path(file)) }
end

# Guard-Rails supports a lot options with default values:
# daemon: false                        # runs the server as a daemon.
# debugger: false                      # enable ruby-debug gem.
# environment: 'development'           # changes server environment.
# force_run: false                     # kills any process that's holding the listen port before attempting to (re)start Rails.
# pid_file: 'tmp/pids/[RAILS_ENV].pid' # specify your pid_file.
# host: 'localhost'                    # server hostname.
# port: 3000                           # server port number.
# root: '/spec/dummy'                  # Rails' root path.
# server: thin                         # webserver engine.
# start_on_start: true                 # will start the server when starting Guard.
# timeout: 30                          # waits untill restarting the Rails server, in seconds.
# zeus_plan: server                    # custom plan in zeus, only works with `zeus: true`.
# zeus: false                          # enables zeus gem.
# CLI: 'rails server'                  # customizes runner command. Omits all options except `pid_file`!

guard 'rails' do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

guard :minitest, :spring => true, env: { 'NO_COVERAGE' => 'true' } do
  watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller\.rb$}) { "test/controllers" }
  watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^app/workers/(.+)\.rb$})                       { |m| "test/unit/workers/#{m[1]}_test.rb" }
  watch(%r{^lib/(.+)\.rb$})                               { |m| "test/unit/lib/#{m[1]}_test.rb" }
  watch(%r{^lib/tasks/(.+)\.rake$})                       { |m| "test/unit/lib/tasks/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$})                       { "test" }
  watch(%r{^test/{fixtures,models}/(.+)\.{rb,yml}$})      { "test/models/#{m[1]}.rb" }
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end
