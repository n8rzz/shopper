update: ## install gems and npm packages
	@echo ""
	bundle install
	@echo ""
	@echo ""
	yarn install --check-dependencies

lint: ## runs linters to check for style inconsistencies
	npm run lint
	bundle exec rubocop

test: ## runs entire test suite
	npm run test
	bundle exec rspec

release: ## updates `master` branch, generates a new tag, pushes tag, pushes master. expects `v={VERSION}` arg
	@echo ""
	git checkout master
	git pull origin	master
	git pull origin develop
	@echo ""
	@echo ""
	@echo ""
	git tag ${v}
	git push origin ${v}
	git push origin master

sync: ## syncs gitlab remote with github remote on {branch}. expects `branch={BRANCH}` arg
	@echo ""
	git checkout ${branch}
	@echo ""
	git pull origin ${branch}
	@echo ""
	git push github ${branch}

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: update lint test release sync
