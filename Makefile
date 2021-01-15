
lint-cli: brew audit Formula/lacework-cli.rb --strict

build-cli-from-source: brew install --build-from-source Formula/lacework-cli.rb 

bump-cli-version: scripts/update-cli-version.sh
