update: ## install gems and npm packages
	@echo ""
	@echo "--- === ::: Updating ruby gems ::: === ---"
	@echo ""
	bundle install
	@echo ""
	@echo "--- === ::: Updating npm packages ::: === ---"
	@echo ""
	yarn install --check-dependencies

lint: ## runs linters to check for style inconsistencies
	yarn lint
	yarn lint:style
	bundle exec rubocop

test: ## runs entire test suite
	@echo ""
	@echo "--- === ::: Starting javascript test suite ::: === ---"
	@echo ""
	npm run test
	@echo ""
	@echo "--- === ::: Starting rspec test suite ::: === ---"
	@echo ""
	bundle exec rspec

release: ## updates `master` branch, generates a new tag, pushes tag, pushes master. expects `v={VERSION}` arg
	@echo ""
	@echo "--- === ::: Updating local `master` ::: === ---"
	@echo ""
	git checkout master
	git pull origin	master
	@echo ""
	@echo "--- === ::: Pulling `develop` ::: === ---"
	@echo ""
	git pull origin develop
	@echo ""
	@echo "--- === ::: Creating next release tag: ${v} ::: === ---"
	@echo ""
	git tag ${v}
	@echo ""
	@echo "--- === ::: Pushing tag to remote ::: === ---"
	@echo ""
	git push origin ${v}
	git push origin master

sync: ## syncs gitlab remote with github remote on {branch}. expects `b={BRANCH}` arg
	@echo ""
	git checkout ${branch}
	@echo ""
	git pull origin ${branch}
	@echo ""
	git push github ${branch}

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: update lint test release sync
