
lint-cli: 
	brew audit Formula/lacework-cli.rb

build-cli-from-source: 
	brew install --build-from-source Formula/lacework-cli.rb 

update-cli-version: 
	scripts/update-cli-version.sh
