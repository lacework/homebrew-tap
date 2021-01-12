<img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600">

# Homebrew Tap
A homebrew tap for Lacework formulas.

## Lacework CLI Formula
The formula for the Lacework command-line interface installation.

### Install
Add the lacework tap and install the lacework cli
```
$ brew tap lacework/tap
$ brew install lacework-cli
```

### Development
When modifying this formula, use the following command to test local changes:
```
$ brew install --build-from-source Formula/lacework-cli.rb
```
Or, copy your changes to the homebrew formula directory and run brew install eg.
```
$ mv path/to/my-test-formula.rb /usr/local/Homebrew/Library/Taps/lacework/homebrew-tap/
$ brew install my-test-formula
```

## License and Copyright

Copyright 2020, Lacework Inc.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
