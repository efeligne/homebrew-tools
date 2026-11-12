# homebrew-tools

A personal [Homebrew](https://brew.sh/) tap for macOS command-line tools.

## Available formulae

| Formula | Description |
| --- | --- |
| `brightness-cli` | Prints the current display brightness as a percentage. |
| `cm` | Generates Git commit messages from staged changes using a local MLX model. |

## Requirements

- macOS
- [Homebrew](https://brew.sh/)
- A Swift toolchain, such as the one provided by Xcode or the Xcode Command Line Tools, to build `brightness-cli`
- A Rust toolchain with Cargo to build `cm`
- A local MLX server to run `cm`

## Installation

Add the tap and install the formulae you need:

```sh
brew tap efeligne/tools
brew install brightness-cli cm
```

Homebrew builds both formulae from source.

## Usage

### `brightness-cli`

Print the current display brightness:

```sh
brightness-cli
```

### `cm`

`cm` generates a Conventional Commits message from the changes in the Git index. It prints the message without staging files or creating a commit.

Install MLX and start the model server:

```sh
brew install uv
uv venv ~/.venvs/mlx
source ~/.venvs/mlx/bin/activate
uv pip install mlx-lm
mlx_lm.server \
  --model mlx-community/Qwen2.5-Coder-7B-Instruct-4bit \
  --host 127.0.0.1 \
  --port 8080
```

The first launch may download the model. Keep the server running, then stage changes and run `cm` in another shell:

```sh
git add <files>
cm
```

The model, server address, maximum diff size per request, and system prompt can be configured with `MLX_MODEL`, `MLX_HOST`, `CM_MAX_DIFF_BYTES`, and `CM_SYSTEM_PROMPT`, respectively.

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

## License

This project is licensed under the [MIT License](LICENSE).
