
lint-cli: 
	brew audit --formula Formula/lacework-cli.rb --strict

install-cli-from-source: 
	brew install --build-from-source Formula/lacework-cli.rb 

test: 
	brew test lacework-cli

update-cli-version: 
	scripts/update-cli-version.sh
