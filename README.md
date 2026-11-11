# brew-tools

A personal [Homebrew](https://brew.sh/) tap for macOS command-line tools.

## Available formulae

| Formula | Description |
| --- | --- |
| `brightness-cli` | Prints the current display brightness as a percentage. |

## Requirements

- macOS
- [Homebrew](https://brew.sh/)
- A Swift toolchain, such as the one provided by Xcode or the Xcode Command Line Tools

## Installation

Add the tap and install a formula:

```sh
brew tap efeligne/tools
brew install brightness-cli
```

Homebrew builds `brightness-cli` from source.

## Usage

Print the current display brightness:

```sh
brightness-cli
```

## Development

Clone the repository and run the setup target to create the local tap, synchronize its formulae, and install them:

```sh
make setup
```

The development commands operate on the local `efeligne/tools` tap.

| Command | Description |
| --- | --- |
| `make list` | List the formulae in this repository. |
| `make sync` | Copy local formulae into the Homebrew tap. |
| `make install FORMULA=brightness-cli` | Build and install one formula from source. |
| `make reinstall FORMULA=brightness-cli` | Reinstall one formula from source. |
| `make install-all` | Build and install every formula from source. |
| `make audit` | Synchronize and strictly audit every formula, including online checks. |
| `make uninstall` | Uninstall every installed formula from this tap. |
| `make clean` | Remove this repository's formulae from the local tap. |
| `make teardown` | Uninstall the formulae and remove their local copies. |

To calculate the SHA-256 checksum for a GitHub release archive:

```sh
make get_shasum REPOSITORY=mac-brightness-cli VERSION=0.1.1
```

### Commit message helper

With a staged Git diff, `make cm` generates a Conventional Commits message using a local [Ollama](https://ollama.com/) server. It requires `git`, `curl`, and `jq`.

The model, server, and maximum diff size can be configured:

```sh
make cm \
  OLLAMA_MODEL=qwen2.5-coder:7b \
  OLLAMA_HOST=http://localhost:11434 \
  CM_MAX_DIFF_BYTES=30000
```

## License

This project is licensed under the [MIT License](LICENSE).
