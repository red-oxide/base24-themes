# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

set dotenv-load := false

dev := if env("IN_NIX_SHELL", "") == "" { "nix develop --command " } else { "" }

# List available recipes
default:
    @just --list

# Check flake outputs and evaluation
check:
    nix flake check

# Format Nix and other configured files
fmt:
    nix fmt

# Check formatting without modifying files (the flake's treefmt check, run on a copy)
fmt-check:
    nix build --no-link ".#checks.$(nix eval --impure --raw --expr builtins.currentSystem).treefmt"

# Show the flake's outputs
show:
    nix flake show

# Update the pins (tack): all, or the ones named, like `just update nixpkgs`
update *names:
    {{ dev }}tack update {{ names }}

# Show which pins have newer upstream revisions
look:
    {{ dev }}tack look

# Run any other tack command
tack *args:
    {{ dev }}tack {{ args }}

# Check formatting and the flake
verify: fmt-check check
