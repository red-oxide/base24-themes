# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{ base24, opacity, ... }:

{
  extraOptions = { inherit opacity; };
  apply = theme: cfg: {
    settings = base24.apps.zathura {
      inherit theme;
      inherit (cfg) opacity;
    };
  };
}
