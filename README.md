# Personal Nix Darwin Configuration
My declarative way to manage  macOS system configuration, including packages, system settings, and development environment using [nix-darwin](https://github.com/LnL7/nix-darwin) and [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer).

## Installation

### 1. Install Nix
First, install Nix using the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer):
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
This will install `nix` with:
- Flakes enabled by default
- Multi-user installation
- macOS upgrade survival
- Automatic store optimization
- Other sensible defaults

> [!NOTE]
> This configuration uses the flakes feature of Nix, which is automatically enabled by the Determinate Nix Installer.

### 2. Install nix-darwin
After installing `nix`, clone this repo:
```bash
git clone https://github.com/CuriousCorrelation/nix-darwin ~/.config/nix-darwin
cd ~/.config/nix-darwin
```

> [!WARNING]
> The following configuration changes are **required** before building. The install might fail and system won't work correctly without updating these details.

Update your personal information in these files:
1. In `modules/home-manager/main.nix`, replace the Git configuration:
```nix
programs.git = {
  userEmail = "your.email@example.com";  # Replace with your email
  userName = "Your Name";                # Replace with your name
};
```

2. In `profiles/main.nix`, replace the username:
```nix
user.name = "yourusername";  # Replace with your username
```

3. In `flake.nix`, replace the hostname:
```nix
darwinConfigurations."Your-MacBook-Name" = darwin.lib.darwinSystem {  # Replace with your hostname
```

> [!TIP]
> Find your hostname by running: `scutil --get LocalHostName`

### 3. Build the Configuration
After updating your personal information, build and activate the configuration:
```bash
nix run nix-darwin -- switch --flake .
```

> [!NOTE]
> The first build might take some time as it downloads and builds all required packages.

## Flake Structure
This configuration uses several flake inputs:
- `nixpkgs`: The main Nix packages repository
- `nix-darwin`: For macOS system configuration
- `home-manager`: For user environment management
- `stable`: Stable NixOS channel for certain packages
- `devenv`: For development environment management
- And various utilities like `flake-utils` and `treefmt-nix`

## Configuration Structure

### Core Configuration
* [flake.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/flake.nix) - Flake configuration and inputs

### Darwin-specific Configurations
* [apps.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/modules/darwin/apps.nix) - macOS applications (via Homebrew)
* [aqua.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/modules/darwin/aqua.nix) - Window manager settings (yabai + skhd)
* [brew.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/modules/darwin/brew.nix) - Homebrew configuration
* [core.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/modules/darwin/core.nix) - Core system settings
* [preferences.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/modules/darwin/preferences.nix) - macOS system preferences

### Home Manager Configurations
* [alacritty.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/modules/home-manager/alacritty.nix) - Terminal emulator config
* [bat.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/modules/home-manager/bat.nix) - bat (cat alternative) config
* [fzf.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/modules/home-manager/fzf.nix) - Fuzzy finder config
* [git.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/modules/home-manager/git.nix) - Git configuration
* [ssh.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/modules/home-manager/ssh.nix) - SSH configuration
* [zsh.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/modules/home-manager/zsh.nix) - Shell configuration

### Profiles
* [profiles/main.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/profiles/main.nix) - Main system profile
* [profiles/home-manager/main.nix](https://github.com/CuriousCorrelation/nix-darwin/blob/main/profiles/home-manager/main.nix) - Main user profile

## Usage

### Adding New Packages
Edit config file (e.g., `modules/darwin/brew.nix` for Homebrew packages or `modules/home-manager/default.nix` for Nix packages) and run the rebuild command.

> [!TIP]
> After making any changes, remember to run `darwin-rebuild switch --flake .` to apply them.

### Updating System
To update all packages and apply changes:
```bash
nix flake update  # Updates all flake inputs
darwin-rebuild switch --flake .
```

> [!TIP]
> You can update specific inputs using `nix flake lock --update-input home-manager` for example.

### Troubleshooting
If you encounter issues:
1. Check system logs: `tail -f /var/log/system.log`
2. Check nix logs: `tail -f /nix/var/log/nix/daemon.log`
3. Run with verbose output: `darwin-rebuild switch --flake . --show-trace -v`

> [!TIP]
> If you get permission errors, make sure you've properly set up your username in the configuration files.

## Uninstalling

> [!IMPORTANT]
> Make sure to uninstall in the correct order to avoid system issues.

1. First uninstall nix-darwin:
```bash
nix run nix-darwin -- uninstall
```

2. Then uninstall Nix:
```bash
/nix/nix-installer uninstall
```

## Inspiration
- https://github.com/kclejeune/system
- https://github.com/MatthiasBenaets/nix-config
- https://github.com/i077/system


## Resources
- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [nix-darwin Manual](https://daiderd.com/nix-darwin/manual/index.html)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Darwin Options](https://mynixos.com/nix-darwin/options)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
