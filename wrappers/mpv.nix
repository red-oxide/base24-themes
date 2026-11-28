# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# The colors go on the command line, as `--name=value` flags.
{ lib, base24, ... }:

{
  apply = theme: _: {
    flags = lib.mapAttrs' (name: lib.nameValuePair "--${name}") (base24.apps.mpv theme);
  };
}
