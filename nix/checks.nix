# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{ inputs, ... }:

{
  perSystem =
    { pkgs, ... }:
    let
      lib = inputs.nixpkgs.lib;

      results = import ../tests {
        inherit lib;
        base24 = inputs.self.lib.base24;
        modules = {
          nixos = inputs.self.nixosModules.default;
          homeManager = inputs.self.homeModules.default;
          homeManagerLegacy = inputs.self.homeManagerModules.default;
        };
      };

      failed = builtins.attrNames (lib.filterAttrs (_: ok: !ok) results);
    in
    {
      checks.base24-themes =
        assert lib.assertMsg (
          failed == [ ]
        ) "base24-themes tests failed: ${lib.concatStringsSep ", " failed}";
        pkgs.runCommandLocal "base24-themes-tests" { } ''
          touch "$out"
        '';
    };
}
