log_color_green = (echo "\x1B[32m>> $1\x1B[39m")
.PHONY: update lint test test-fe test-be-unit test-feature test-be-unit-profile test-feature-profile release sidekiq sync launch-reports

update: ## install gems and npm packages
	@echo ""
	@$(call log_color_green, "-- === ::: Updating ruby gems ::: === ---")
	@echo ""
	bundle install
	@echo ""
	@$(call log_color_green, "-- === ::: Updating npm packages ::: === ---")
	@echo ""
	yarn install --check-dependencies

lint: ## runs linters to check for style inconsistencies
	yarn lint
	yarn lint:style
	bundle exec rubocop

test-fe: ## runs just frontend tests
	@echo ""
	@$(call log_color_green, "--- === ::: Starting javascript test suite ::: === ---")
	@echo ""
	npm run test

test-be-unit: ## runs just rspec unit tests
	@echo ""
	@$(call log_color_green, "--- === ::: Starting RSPEC UNIT test suite ::: === ---")
	@echo ""
	export RUBYOPT='-W:no-deprecated -W:no-experimental'; bundle exec rspec --exclude-pattern "spec/features/**/*_spec.rb"

test-feature: ## runs rspec feature tests
	@echo ""
	@$(call log_color_green, "--- === ::: Starting RSPEC FEATURE test suite ::: === ---")
	@echo ""
	export RUBYOPT='-W:no-deprecated -W:no-experimental'; bundle exec rspec spec/features/**/*_spec.rb --failure-exit-code 0

test-be-unit-profile: ## runs just rspec unit tests
	@echo ""
	@$(call log_color_green, "--- === ::: Starting RSPEC UNIT test suite ::: === ---")
	@echo ""
	export RUBYOPT='-W:no-deprecated -W:no-experimental'; bundle exec rspec --exclude-pattern "spec/features/**/*_spec.rb" --profile

test-feature-profile: ## runs rspec feature tests
	@echo ""
	@$(call log_color_green, "--- === ::: Starting RSPEC FEATURE test suite ::: === ---")
	@echo ""
	export RUBYOPT='-W:no-deprecated -W:no-experimental'; bundle exec rspec spec/features/**/*_spec.rb --profile --failure-exit-code 0

test: test-fe test-be-unit test-feature

test-profile: test-fe test-be-unit-profile test-feature-profile

release: ## updates `master` branch, generates a new tag, pushes tag, pushes master. expects `v={VERSION}` arg
	@echo ""
	@$(call log_color_green, "-- === ::: Updating local `master` ::: === ---")
	@echo ""
	git checkout master
	git pull origin	master
	@echo ""
	@$(call log_color_green, "-- === ::: Pulling `develop` ::: === ---")
	@echo ""
	git pull origin develop
	@echo ""
	@$(call log_color_green, "-- === ::: Creating next release tag: ${v} ::: === ---")
	@echo ""
	git tag ${v}
	@echo ""
	@$(call log_color_green, "-- === ::: Pushing tag to remote ::: === ---")
	@echo ""
	git push origin ${v}
	git push origin master

sidekiq: ## spins up sidekiq process
	bundle exec sidekiq

start: ## start app using foreman and Procfile.dev to run app and services locally
	foreman start -f Procfile.dev

sync: ## syncs gitlab remote with github remote on {branch}. expects `b={BRANCH}` arg
	@echo ""
	git checkout ${b}
	@echo ""
	git pull origin ${b}
	@echo ""
	git push github ${b}

launch-reports: ## spings up an http-server to serve coverage reports for BE tests
	http-server ./coverage/ -d -p 9987 -c -1

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
