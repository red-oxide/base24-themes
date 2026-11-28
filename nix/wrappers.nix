# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# Modules for nix-wrapper-modules wrappers: import one into the matching
# wrapper (kitty, helix, ...) and set `base24.theme` to color it with
# `lib.base24.apps`. This flake doesn't depend on nix-wrapper-modules; the
# modules only set the wrappers' own options.
{ config, lib, ... }:

let
  base24 = config.flake.lib.base24;

  themeOption = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.either (lib.types.enum (builtins.attrNames base24.themes)) (lib.types.attrsOf lib.types.str)
    );
    default = null;
    example = "birdland";
    description = ''
      A theme bundled with base24-themes, or a custom Base16/Base24 theme as an
      attrset. Null leaves the program's colors alone.
    '';
  };
  resolve = theme: if builtins.isString theme then base24.themes.${theme} else theme;

  # A module setting `apply resolvedTheme cfg` when a theme is chosen.
  themed =
    {
      extraOptions ? { },
      apply,
    }:
    { config, lib, ... }:
    let
      cfg = config.base24;
    in
    {
      options.base24 = {
        theme = themeOption;
      }
      // extraOptions;
      config = lib.mkIf (cfg.theme != null) (apply (resolve cfg.theme) cfg);
    };

  opacity = lib.mkOption {
    type = lib.types.numbers.between 0 1;
    default = 1.0;
    description = "Background opacity; below 1, the background is left to the compositor.";
  };
in
{
  flake.wrapperModules = {
    kitty = themed {
      extraOptions = { inherit opacity; };
      apply = theme: cfg: {
        settings = base24.apps.kitty theme // {
          background_opacity = lib.mkIf (cfg.opacity != 1.0) (toString cfg.opacity);
        };
      };
    };

    helix = themed {
      extraOptions.transparent = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Leave the editor's background to the terminal.";
      };
      apply = theme: cfg: {
        themes.base24 = base24.apps.helix { inherit theme; inherit (cfg) transparent; };
        settings.theme = lib.mkDefault "base24";
      };
    };

    zathura = themed {
      extraOptions = { inherit opacity; };
      apply = theme: cfg: {
        settings = base24.apps.zathura { inherit theme; inherit (cfg) opacity; };
      };
    };

    mpv = themed {
      apply = theme: _: {
        flags = lib.mapAttrs' (name: lib.nameValuePair "--${name}") (base24.apps.mpv theme);
      };
    };

    yazi = themed {
      apply = theme: _: { settings.theme = base24.apps.yazi theme; };
    };

    niri = themed {
      apply = theme: _: { settings.layout = base24.apps.niri theme; };
    };
  };
}
