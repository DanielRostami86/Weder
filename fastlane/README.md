fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### create_app

```sh
[bundle exec] fastlane create_app
```

Create on Developer Portal and AppStore Connect

----


## iOS

### ios setup_github_ci

```sh
[bundle exec] fastlane ios setup_github_ci
```

Create new Keychain for signing

### ios signing

```sh
[bundle exec] fastlane ios signing
```

Sync signing

### ios set_manual_signing

```sh
[bundle exec] fastlane ios set_manual_signing
```

Manual Signing

### ios build

```sh
[bundle exec] fastlane ios build
```

Build binary

### ios release

```sh
[bundle exec] fastlane ios release
```

Release

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
