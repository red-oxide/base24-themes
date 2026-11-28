# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# Adds the theme as `base24` and selects it, at default priority so another
# can still be picked.
{ lib, base24, ... }:

{
  extraOptions.transparent = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Leave the editor's background to the terminal.";
  };
  apply = theme: cfg: {
    themes.base24 = base24.apps.helix {
      inherit theme;
      inherit (cfg) transparent;
    };
    settings.theme = lib.mkDefault "base24";
  };
}
