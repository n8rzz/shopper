update:
	bundle
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


