<img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600">


# Homebrew Lacework CLI
A homebrew tap for the Lacework command line interface.

## Install
Add the lacework tap and install the lacework cli
```
brew tap lacework/lacework-cli

brew install lacework-cli
```

## Development
When modifying this formula, use the following command to test local changes:
```
brew install --build-from-source Formula/lacework-cli.rb

```
Or, copy your changes to the homebrew formula directory and run brew install eg.
```
mv path/to/my-test-formula.rb /usr/local/Homebrew/Library/Taps/lacework/homebrew-lacework-cli/

brew install my-test-formula
```