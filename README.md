# ZSHBuddy

Zero-configuration ZSH enhancement suite that makes your shell more modern and awesome.

## Features

- **Performance**: ZSHBuddy is designed with performance in mind, using antidote plugin manager that is using deferred loading to ensure your shell starts up quickly.
- **Simplicity**: No need to manually configure plugins or themes. ZSHBuddy works out of the box with sensible defaults.
- **Modern Features**: Includes a curated set of modern plugins and tools to enhance your shell experience like auto suggestion, fuzzy tab completion etc
- **Easy Installation**: A single command to install and set up everything you need.

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
- **fd**: A simple, fast and user-friendly alternative to `find`. [GitHub](https://github.com/sharkdp/fd)
- **bat**: A cat clone with syntax highlighting and Git integration, aliased to the regular `cat`, so it will just work. [GitHub](https://github.com/sharkdp/bat)

### Additional shell aliases

- **va** - python's virtual env activate (look all way up through directories to find first .venv)
- **vd** - python's virtual env deactivate
- **ls** - enabled colors, directories first, human readable file sizes
- **ll** - list files (verbose)
- **la** - list files including hidden (dot files)
- **cat** - shows files contents with `bat` (enhanced view).

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

none :)

## Backup and Recovery

ZSHBuddy automatically creates backup of your existing configurations before making any changes. Backups are stored in `~/.zshbuddy/backup/` with timestamps.

## Requirements

- macOS or Linux (Ubuntu/Debian supported)

## Why Not Oh My Zsh or other alternative?

While Oh My Zsh is a fantastic framework for managing your Zsh configuration, ZSHBuddy aims to provide a more streamlined and performance-optimized experience with zero configuration required. 
By choosing ZSHBuddy, you get a powerful, modern, and efficient Zsh setup with minimal effort.
Instantly makes VM's shell to feel like home etc.

## License

MIT License - See LICENSE file for details
