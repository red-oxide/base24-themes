# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# Application color settings, one file per program like lib/apps/<app>.nix.
# Each gets a Base16 theme (so base24's colors come from the fallbacks) and
# `hex name` for the "#rrggbb" it should produce. Returns { "<app>.<test>" = bool; }.
{
  lib,
  base24,
  fixtures,
  ...
}@args:

let
  theme = fixtures.base16Theme;
  colors = base24.getColors theme;
  hex = name: "#${colors.${name}}";

  files = lib.filterAttrs (
    name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
  ) (builtins.readDir ./.);
  suites = lib.mapAttrs' (
    file: _:
    lib.nameValuePair (lib.removeSuffix ".nix" file) (import ./${file} (args // { inherit theme hex; }))
  ) files;

  wrappers = import ../../wrappers { inherit lib base24; };
in
lib.concatMapAttrs (app: lib.mapAttrs' (test: lib.nameValuePair "${app}.${test}")) suites
// {
  # Every program has its colors and its tests, and every wrapper module a
  # program's colors. (Toolkits such as gtk and qtct have no wrapper.)
  "files.match" =
    let
      names = builtins.attrNames;
    in
    names base24.apps == names suites && lib.all (n: base24.apps ? ${n}) (names wrappers);
}
