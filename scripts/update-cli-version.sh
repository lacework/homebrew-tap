#!/bin/bash

set -eou pipefail

readonly package_name=lacework-cli
readonly cli_formula=Formula/lacework-cli.rb
readonly git_user="Lacework Inc."
readonly git_email="tech-ally@lacework.net"

TARGETS=(
  ${package_name}-darwin-arm64.zip
  ${package_name}-darwin-amd64.zip
  ${package_name}-linux-386.tar.gz
  ${package_name}-linux-amd64.tar.gz
  ${package_name}-linux-arm.tar.gz
  ${package_name}-linux-arm64.tar.gz
)

main() {
  version=$(find_latest_version)
  currentVersion=$(cat "$cli_formula" | grep 'VERSION = '| sed 's/.*VERSION = "\(.*\)".freeze/\1/')

  [[ $version != $currentVersion ]] || { echo >&2 "Formula is already on latest version"; exit 1; }

  echo "Updating current: $currentVersion with latest: $version"
  update_version $currentVersion $version

  for target in ${TARGETS[*]}; do
      replace_sha_sum $version $target
  done

  push_update_formula $version
}

find_latest_version() {
  echo $(curl -s "https://api.github.com/repos/lacework/go-sdk/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' )
}

replace_sha_sum() {
  local _shasum=$(curl -sL "https://github.com/lacework/go-sdk/releases/download/$1/$2.sha256sum" | cut -d " " -f1)
  if [ `uname -s` == "Darwin" ]; then
    sed -i '' '/'$2'/{n;s/^\( *\)sha256.*/\1sha256 "'$_shasum'"/;}' "$cli_formula"
  else
    sed -i '/'$2'/{n;s/^\( *\)sha256.*/\1sha256 "'$_shasum'"/;}' "$cli_formula"
  fi
}

update_version() {
  if [ `uname -s` == "Darwin" ]; then
    sed -i '' 's/VERSION = "'$1'"/VERSION = "'$2'"/' "$cli_formula"
  else
    sed -i 's/VERSION = "'$1'"/VERSION = "'$2'"/' "$cli_formula"
  fi
}

push_update_formula() {
  echo "commiting and pushing the updated formula to github"
  if [ "$CI" != "" ]; then
    git config --global user.email $git_email
    git config --global user.name $git_user
    git config --global user.signingkey $GPG_SIGNING_KEY
  fi
  git commit -sS -am "ci: update lacework-cli formula to $1"
  git push origin main
}

main "$@"

