# Install

Works on macOS and Linux. Needs [Homebrew](https://brew.sh) (on Linux: Linuxbrew in `/home/linuxbrew/.linuxbrew`).

```sh
git clone git@github.com:Jnig/.dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

`install.sh` can be run again at any time. It:

- links the configs into `~` and `~/.config` (Ghostty, AeroSpace and Karabiner only on macOS)
- installs packages from `Brewfile` (macOS apps only on macOS)
- on macOS, runs `setup-macos.sh` (login items, SSH keychain, Dock)

The first new shell installs zinit and the zsh plugins.

## Updating

New shells say when the dotfiles are behind GitHub, have unpushed commits or uncommitted changes. Pull with `dotup`.

## Machine-specific settings

Put anything machine-specific or secret in `~/.zshrc.local` (not in git).
