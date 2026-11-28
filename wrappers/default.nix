# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# Modules for nix-wrapper-modules wrappers, one file per program
# (wrappers/<app>.nix, matching lib/apps/<app>.nix): import one into the
# matching wrapper (kitty, helix, ...) and set `base24.theme` to color it with
# `lib.base24.apps`. This doesn't depend on nix-wrapper-modules; the modules
# only set the wrappers' own options. Pure, like lib/:
#
#   wrappers = import "${base24-themes}/wrappers" { inherit lib base24; };
#
# Each app file returns { extraOptions ? { }, apply }, where
# `apply theme cfg` gives the wrapper's config once a theme is chosen
# (`cfg` is the module's `base24` options).
{ lib, base24 }:

let
  themeOption = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.either (lib.types.enum (builtins.attrNames base24.themes)) (
        lib.types.attrsOf lib.types.str
      )
    );
    default = null;
    example = "birdland";
    description = ''
      A theme bundled with base24-themes, or a custom Base16/Base24 theme as an
      attrset. Null leaves the program's colors alone.
    '';
  };
  resolve = theme: if builtins.isString theme then base24.themes.${theme} else theme;

  # Shared by the apps whose background can be translucent.
  opacity = lib.mkOption {
    type = lib.types.numbers.between 0 1;
    default = 1.0;
    description = "Background opacity; below 1, the background is left to the compositor.";
  };

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

  files = lib.filterAttrs (
    name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
  ) (builtins.readDir ./.);
in
lib.mapAttrs' (
  file: _:
  lib.nameValuePair (lib.removeSuffix ".nix" file) (
    themed (import ./${file} { inherit lib base24 opacity; })
  )
) files
