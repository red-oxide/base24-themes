# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  lib,
  base24,
  opacity,
  ...
}:

{
  extraOptions = { inherit opacity; };
  apply = theme: cfg: {
    settings = base24.apps.kitty theme // {
      background_opacity = lib.mkIf (cfg.opacity != 1.0) (toString cfg.opacity);
    };
  };
}
