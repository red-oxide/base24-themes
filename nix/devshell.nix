# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# devfmt's shell plus reuse and the pinned tack.
{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      config,
      system,
      ...
    }:
    {
      devShells.default = pkgs.mkShellNoCC {
        packages = [
          config.treefmt.build.wrapper
          pkgs.just
          pkgs.reuse
          inputs.tack.packages.${system}.tack
        ];
      };
    };
}
