# fspi - Fedora Sway Post-Install

Idempotent shell script framework for provisioning a Fedora Sway (Wayland) desktop environment. Pure Bash -- no compiled languages, no package managers beyond DNF/Flatpak, no build tools beyond shell.

## What This Project Does

Transforms a fresh Fedora Sway spin into a complete development workstation:

- **Desktop environment**: Sway WM + Waybar status bar + Dunst notifications + Rofi launcher
- **Terminals**: WezTerm (primary, via Flatpak), Foot (secondary)
- **Editor**: Neovim with LazyVim distribution
- **Shell**: Zsh with Oh-My-Zsh, syntax highlighting, autosuggestions, fzf
- **Dev tools**: Mise (version manager for Ruby/Java/Node), Docker, Azure CLI, kubectl, k9s, glab
- **Corporate**: OpenConnect VPN with vpn-slice for Cetin network, GitLab MR monitoring in waybar
- **Utilities**: Screenshot pipeline (wayfreeze+grim+slurp+satty), clipboard manager, power profile switching, system inhibitor, JPG-to-PDF-with-OCR

## Project Structure

```
fspi/
├── install.sh          # Entry point -- runs all steps in order
├── lib/
│   ├── logging.sh      # log_info, log_warn, log_error, log_debug
│   └── utils.sh        # Idempotent helpers (ensure_package, ensure_symlink, etc.)
├── steps/              # Numbered scripts (00-30) executed sequentially
│   ├── 00-09           # Base system (repos, packages, SELinux, swap, timezone)
│   ├── 10-19           # Tools built from source (LazyVim, mise, Docker, wayfreeze, satty)
│   ├── 20-29           # Config deployment (dotfiles, color schemes, desktop entries, Zsh)
│   └── 30+             # Script deployment
├── config/             # Dotfiles deployed to ~/.config/ by step 20
├── scripts/            # User scripts deployed to ~/scripts/ by step 30
│   └── waybar/         # Waybar custom module scripts
└── files/              # Static assets (desktop entries, icons)
```

## Running

```bash
./install.sh            # Run all steps sequentially
DEBUG=1 ./install.sh    # Run with verbose debug output
bash steps/02_packages.sh   # Run a single step directly
```

Each step is standalone and can be run independently.

## Code Conventions

### Shebang and Safety

Every script starts with:
```bash
#!/usr/bin/env bash
set -euo pipefail
```

### Script Bootstrapping

Every step resolves the project root and sources libraries:
```bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
source "$SCRIPT_DIR/lib/logging.sh"
source "$SCRIPT_DIR/lib/utils.sh"
```

Source `logging.sh` before `utils.sh` (utils depends on logging).

### Naming

- **Step files**: `NN_descriptive_name.sh` -- two-digit prefix controls order
- **Functions**: `snake_case`
- **Constants**: `UPPER_SNAKE_CASE`
- **Local vars**: `lower_snake_case`, use `local` inside functions

### Idempotency (Critical)

ALL steps MUST be safe to run multiple times. Use check-then-act:
```bash
if [[ <already done> ]]; then
    log_debug "Already done, skipping"
else
    log_info "Doing the thing..."
    <actual work>
fi
```

Prefer the `ensure_*` helpers from `lib/utils.sh`.

### Logging

- `log_info` -- significant actions (always visible)
- `log_debug` -- skip/already-done messages (visible with `DEBUG=1`)
- `log_warn` -- non-fatal issues
- `log_error` -- fatal errors

### Formatting

- 2-space indentation
- `[[ ]]` for conditionals (not `[ ]`)
- `$(command)` for substitution (not backticks)
- Quote all variable expansions
- Comments may be Czech or English; log messages in English

## Key Utility Functions (lib/utils.sh)

| Function | Purpose |
|---|---|
| `ensure_package "pkg"` | Install DNF package if missing |
| `ensure_repo "name" "url"` | Add DNF repo if not present |
| `ensure_symlink "target" "dest"` | Create symlink idempotently |
| `ensure_file_copy "src" "dest"` | Copy file only if changed |
| `ensure_user_in_group "user" "group"` | Add user to group if needed |
| `ensure_command "cmd"` | Assert command exists, exit if not |
| `check_command "cmd"` | Check if command exists (bool) |
| `run_sudo "cmd"` | Run with sudo if not already root |

## Config Deployment

`steps/20_config.sh` deploys files from `config/` to `~/.config/` using `config_step_copy_collection`. The function handles: missing source (skip with warning), missing target (copy), identical content (skip), different content (timestamped backup then copy). Never overwrite files containing user credentials.

## Tests / Linting

No test framework or CI. Validate by running steps directly on a Fedora Sway system. Use `shellcheck` manually:
```bash
shellcheck steps/*.sh lib/*.sh install.sh
```

## Adding a New Step

Create `steps/XX_name.sh`:
```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
source "$SCRIPT_DIR/lib/logging.sh"
source "$SCRIPT_DIR/lib/utils.sh"

log_info "Step XX: Description"

if [[ <already done> ]]; then
    log_debug "Already configured, skipping"
else
    log_info "Configuring..."
    # ... actual work ...
fi

log_info "Step XX complete"
```

## Adding Packages

Add to the `PACKAGES` array in `steps/02_packages.sh`.
