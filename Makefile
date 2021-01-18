
lint-cli: 
	brew audit --formula Formula/lacework-cli.rb --strict

build-cli-from-source: 
	brew install --build-from-source Formula/lacework-cli.rb 

update-cli-version: 
	scripts/update-cli-version.sh
