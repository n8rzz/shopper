update: ## install gems and npm packages
	bundle install
	yarn install --check-dependencies

lint: ## runs linters to check for style inconsistencies
	npm run lint
	bundle exec rubocop

test: ## runs entire test suite
	npm run test
	bundle exec rspec

release: ## updates `master` branch, generates a new tag, pushes tag, pushes master. expects `v={VERSION}` arg
	git checkout master
	git pull origin	master
	git pull origin develop
	git tag ${v}
	git push origin ${v}
	git push origin master

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: update lint test release
