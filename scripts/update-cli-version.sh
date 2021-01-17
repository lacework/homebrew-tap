#!/bin/bash

readonly package_name=lacework-cli
readonly cli_formula=Formula/lacework-cli.rb

TARGETS=(
  ${package_name}-darwin-amd64.zip
  ${package_name}-linux-386.tar.gz
  ${package_name}-linux-amd64.tar.gz
  ${package_name}-linux-arm.tar.gz
  ${package_name}-linux-arm64.tar.gz
)

main() {
  version=$(find_latest_version)
  currentVersion=$(cat $cli_formula | grep 'VERSION = '| cut -d "=" -f2 | tr -d '"' | tr -d ' ')

  [[ $version != $currentVersion ]] || { echo >&2 "Formula is already on latest version"; exit 1; }
    
    echo "Updating current: $currentVersion with latest: $version"
    update_version $currentVersion $version

    for target in ${TARGETS[*]}; do
        replace_sha_sum $version $target
    done
}

find_latest_version() {
  echo $(curl -s "https://api.github.com/repos/lacework/go-sdk/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' )
}

replace_sha_sum() {
  local _shasum=$(curl -sL "https://github.com/lacework/go-sdk/releases/download/$1/$2.sha256sum" | cut -d " " -f1)
  sed -i '' '/'$2'/{n;s/.*/    sha256 "'$_shasum'"/;}' $cli_formula
}

update_version() {
  sed -i '' 's/VERSION = "'$1'"/VERSION = "'$2'"/' $cli_formula
}

main "$@"
