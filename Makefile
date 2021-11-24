
.PHONY: help
help:
	@echo "-------------------------------------------------------------------"
	@echo "Lacework Homebrew Makefile helper:"
	@echo ""
	@grep -Fh "##" $(MAKEFILE_LIST) | grep -v grep | sed -e 's/\\$$//' | sed -E 's/^([^:]*):.*##(.*)/ \1 -\2/'
	@echo "-------------------------------------------------------------------"

.PHONY: lint-cli
lint-cli: ## Run brew audit
	brew audit --formula Formula/lacework-cli.rb --strict

install-cli-from-source: 
	brew install --build-from-source Formula/lacework-cli.rb 

test: 
	brew test lacework-cli

update-cli-version: 
	scripts/update-cli-version.sh

install-check-warnings: 
	scripts/install-from-source.sh
