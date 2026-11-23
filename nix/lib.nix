# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{ lib, ... }:

{
  flake.lib.base24 = import ../lib { inherit lib; };
}
