# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# Runs every suite and returns { "<suite>.<test>" = bool; }.
#   base24:  the library (lib/)
#   modules: { nixos, homeManager, homeManagerLegacy } exported by the flake
#            (homeModules.default and homeManagerModules.default)
{
  lib,
  base24,
  modules,
}:

let
  args = {
    inherit lib base24 modules;
    fixtures = import ./fixtures.nix { inherit lib; };
  };

  suites = {
    core = ./core.nix;
    contrast = ./contrast.nix;
    formats = ./formats.nix;
    apps = ./apps.nix;
    themes = ./themes.nix;
    module = ./module.nix;
  };
in
lib.concatMapAttrs (
  suite: file: lib.mapAttrs' (test: lib.nameValuePair "${suite}.${test}") (import file args)
) suites
