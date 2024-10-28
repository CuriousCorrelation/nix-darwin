# Personal Nix Darwin Configuration
My declarative way to manage my macOS system configuration, including packages, system settings, and development environment with personal Nix configuration for macOS using [nix-darwin](https://github.com/LnL7/nix-darwin) and [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer).

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

## Configuration Structure
The configuration is organized as follows:
```
.
├── flake.nix              # Flake configuration and inputs
├── modules/
│   ├── darwin/           # Darwin-specific system configurations
│   │   ├── apps.nix      # macOS applications (via Homebrew)
│   │   ├── aqua.nix      # Window manager settings (yabai + skhd)
│   │   ├── brew.nix      # Homebrew configuration
│   │   ├── core.nix      # Core system settings
│   │   └── preferences.nix # macOS system preferences
│   └── home-manager/     # User environment configurations
│       ├── alacritty.nix # Terminal emulator config
│       ├── bat.nix       # bat (cat alternative) config
│       ├── fzf.nix       # Fuzzy finder config
│       ├── git.nix       # Git configuration
│       ├── ssh.nix       # SSH configuration
│       └── zsh.nix       # Shell configuration
└── profiles/            # Environment profiles
    ├── main.nix         # Main system profile
    └── home-manager/    # User profiles
        └── main.nix     # Main user profile
```

### Adding New Packages
Edit config file (e.g., `modules/darwin/brew.nix` for Homebrew packages or `modules/home-manager/default.nix` for Nix packages) and run the rebuild command.

> [!TIP]
> After making any changes, remember to run `darwin-rebuild switch --flake .` to apply them.

### Updating System
To update all packages and apply changes:
```bash
nix flake update
darwin-rebuild switch --flake .
```

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
nix run nix-darwin# darwin-uninstaller
```

2. Then uninstall Nix:
```bash
/nix/nix-installer uninstall
```

## Resources
- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [nix-darwin Manual](https://daiderd.com/nix-darwin/manual/index.html)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Darwin Options](https://daiderd.com/nix-darwin/manual/options.html)
