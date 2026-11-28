<!--
SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
SPDX-License-Identifier: MIT
-->

# base24-themes

[Base24](https://github.com/tinted-theming/base24) color schemes for Nix, with a
small library of format converters and a module for NixOS and Home Manager.

**[Usage & configuration options →](./docs/usage.md)**

**[Theme gallery →](./docs/gallery.md)**

## Features

- **Bundled themes**, each with a dark variant and a `-light` one:
  [`birdland`](./docs/birdland.md), [`spangled`](./docs/spangled.md),
  [`eastern-shore`](./docs/eastern-shore.md),
  [`blue-crab`](./docs/blue-crab.md), [`harbor`](./docs/harbor.md) and
  [`red-oxide`](./docs/red-oxide.md). Every accent reaches 4.5:1 contrast on the
  background, and `nix flake check` tests it. Every file in `themes/` is picked
  up automatically.
- **Format converters**: `toYaml` (tinted-theming scheme format), `toJson`,
  `toScss`, `toQml`, `toSvg` (the palette preview images) and `toCardSvg` (the
  gallery cards).
- **Application colors**: `apps.kitty`, `apps.helix`, `apps.zathura`,
  `apps.mpv`, `apps.yazi` and `apps.niri` give each program's color settings as
  a Nix attrset, and `wrapperModules.<app>` applies them to a
  [nix-wrapper-modules](https://github.com/nix-community/nix-wrapper-modules)
  wrapper with one `base24.theme` option.
- **GTK and Qt apps**: `nixosModules.toolkits` colors GTK 3, GTK 4, libadwaita,
  Qt 5 and Qt 6 apps (`base24.gtk.enable`, `base24.qt.enable`).
- **Validation**: themes are checked for missing or malformed colors, and
  `nix flake check` verifies every bundled theme.
- **Module**: one module for NixOS and Home Manager that exposes the selected
  theme as `config.lib.base24`.

## Installation

Add `base24-themes` as an input in your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    base24-themes.url = "github:red-oxide/base24-themes";
    base24-themes.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, base24-themes, ... }: {
    # Your flake outputs...
  };
}
```

`github:red-oxide/base24-themes` follows master. To pin a release, use its tag,
such as `github:red-oxide/base24-themes/v26.0.0`; see the
[changelog](./CHANGELOG.md).

## Development

```sh
nix flake check   # run the tests (also run in CI on every push and pull request)
nix fmt           # format
just update       # move the pins (tack), or `just update nixpkgs` for one
```

The flake has no inputs: nixpkgs, devfmt and tack are pinned with
[tack](https://github.com/manic-systems/tack) in `.tack/pins.toml`, and CI
updates the lock daily. Using the flake doesn't need tack.

```
lib/
  default.nix        library entry point (`lib.base24`)
  core.nix           validation, fallbacks, color access
  themes.nix         loads themes/
  gallery.nix        generates docs/gallery.md
  formats/           one file per exporter: yaml, json, scss, qml, svg, card
  apps/              one file per program's color settings (`lib.base24.apps`)
wrappers/            one nix-wrapper-modules module per program
nix/                 flake-parts glue, loaded automatically
  lib.nix            exports lib.base24
  module.nix         NixOS / Home Manager module
  toolkits.nix       NixOS module for GTK and Qt apps
  wrappers.nix       exports wrapperModules
  checks.nix         turns tests/ into `nix flake check`
tests/               one suite per area, plus shared fixtures
themes/              one file per theme
previews/            generated SVG previews (and cards/ for the gallery)
docs/                usage guide, theme pages and the gallery
.tack/               pins: pins.toml is ours, tack writes the rest
```

To add a format, create `lib/formats/<name>.nix` (it receives `{ lib, core }`
and returns a `theme -> string` function), register it in `lib/default.nix` and
add a test to `tests/formats.nix`.

To add a program, create files named after it; each directory picks up every
file in it, so nothing needs registering:

- `lib/apps/<name>.nix`: receives `{ lib, core, hex, rgb }` and returns a
  function from a theme to the program's settings.
- `tests/apps/<name>.nix`: its tests.
- `wrappers/<name>.nix`, for a program with a nix-wrapper-modules wrapper:
  receives `{ lib, base24, opacity }` and returns
  `{ extraOptions ? { }, apply }`, where `apply theme cfg` is the wrapper's
  config. Toolkits (`gtk`, `qtct`) have none.

A check fails if a program has no tests or a wrapper has no colors.

## License

MIT. See [LICENSE](./LICENSE).
