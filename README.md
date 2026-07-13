# Moonstone Homebrew Tap

This is the official Homebrew tap for
[Moonstone](https://moonstone.sh), the modern, content-addressed package manager and deterministic environment orchestrator for Lua.

## Installation

To install Moonstone via Homebrew on macOS or Linux, run:

```bash
brew tap moonstone-sh/moonstone
brew install moonstone
```

### Upgrading

To upgrade Moonstone to the latest version, simply run:
```
brew update
brew upgrade moonstone
```

## What is Moonstone?

Moonstone is an operating system for Lua. It guarantees determinism by tightly coupling your project to a specific interpreter and ABI, managing symlinked  .moonstone/env isolations so your host machine stays perfectly clean.

For full documentation, guides, and advanced usage, visit https://moonstone.sh.

## Issues & Contributing

The formula in this repository is automatically updated by the CI/CD pipeline of the main Moonstone repository.

If you encounter any issues or want to contribute, please open an issue or pull request in the main repository:
👉 moonstone-sh/moonstone https://github.com/moonstone-sh/moonstone
