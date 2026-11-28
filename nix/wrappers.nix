# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# nix-wrapper-modules modules, one per program (wrappers/<app>.nix).
{ config, lib, ... }:

{
  flake.wrapperModules = import ../wrappers {
    inherit lib;
    base24 = config.flake.lib.base24;
  };
}
