# ZSHBuddy

Zero-configuration ZSH enhancement suite that makes your shell more modern and awesome.
Basically, it's just an installer for [Antidote](https://github.com/mattmc3/antidote) zsh plugin manager with some specific configuration.

## Features

- **Easy Installation**: A single command to install and set up everything you need.
- **Performance**: ZSHBuddy is designed with performance in mind, using the Antidote plugin manager, which leverages deferred loading to ensure your shell starts up quickly. Unlike traditional plugin managers, Antidote is highly optimized for speed and minimal resource usage.
- **Simplicity**: No need to manually configure plugins or themes. ZSHBuddy works out of the box with sensible defaults.
- **Modern Features**: Includes a curated set of modern plugins and tools to enhance your shell experience, like auto-suggestions, fuzzy tab completion, and syntax highlighting.

## Installation

- Clone the repository
```bash
git clone https://github.com/giosad/zshbuddy.git ~/.zshbuddy
```

- Run the installer

```bash
~/.zshbuddy/installer.sh
```

## Uninstallation

```bash
~/.zshbuddy/installer.sh uninstall
```

## Installed Console Commands

After installing ZSHBuddy, the following console commands are available:

- **z**: Quickly navigate to directories you have visited before. [GitHub](https://github.com/rupa/z)
- **fzf**: Fuzzy finder for files and directories, it also will be used for all tab completions. [GitHub](https://github.com/junegunn/fzf)
- **fd**: A simple, fast, and user-friendly alternative to `find`. [GitHub](https://github.com/sharkdp/fd)
- **bat**: A `cat` clone with syntax highlighting and Git integration, aliased to the regular `cat`, so it will just work. [GitHub](https://github.com/sharkdp/bat)

### Additional Shell Aliases

- **va** - Python virtual env activate (searches up directories for `.venv`)
- **vd** - Python virtual env deactivate
- **ls** - Enabled colors, directories first, human-readable file sizes
- **ll** - List files (verbose)
- **la** - List files including hidden (dot files)
- **cat** - Shows file contents with `bat` (enhanced view)

## Included Plugins

- **[Powerlevel10k](https://github.com/romkatv/powerlevel10k)**: Beautiful and informative terminal prompt.
- **[fzf-tab](https://github.com/Aloxaf/fzf-tab)**: Enhanced tab completion using `fzf`.
- **[z](https://github.com/rupa/z)**: Smart directory jumping.
- **[fz.sh](https://github.com/mrjohannchang/fz.sh)**: Fuzzy search integration for `z`.
- **[zsh-bat](https://github.com/fdellwing/zsh-bat)**: Enhanced file viewing with `bat`.
- **[zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)**: Smart history search.
- **[fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)**: Command syntax highlighting.
- **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)**: Fish-like autosuggestions.

## Configuration

ZSHBuddy installs Antidote with a specific curated configuration, ensuring an optimized and smooth shell experience without additional manual setup.

## Backup and Recovery

ZSHBuddy automatically creates a backup of your existing configurations before making any changes. Backups are stored in `~/.zshbuddy/backup/` with timestamps.

## Requirements

- macOS or Linux (Ubuntu/Debian supported)

## Why Not Oh My Zsh or Other Alternatives?

While Oh My Zsh is a fantastic framework for managing your Zsh configuration, ZSHBuddy aims to provide a more streamlined and performance-optimized experience with zero configuration required. 
By choosing ZSHBuddy, you get a powerful, modern, and efficient Zsh setup with minimal effort. Unlike Oh My Zsh, which loads all plugins on startup, ZSHBuddy leverages Antidote’s deferred plugin loading, ensuring a faster and smoother experience.

This setup is ideal for making VM shells feel like home instantly.

## License

MIT License - See LICENSE file for details

