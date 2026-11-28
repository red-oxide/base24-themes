# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  lib,
  base24,
  theme,
  ...
}:

let
  zathura = base24.apps.zathura { inherit theme; };
in
{
  # rgb()/rgba(), not hex, so the opacity can apply.
  colors =
    lib.hasPrefix "rgba(" zathura.default-bg
    && lib.hasPrefix "rgb(" zathura.statusbar-bg
    && !(lib.hasInfix "#" zathura.statusbar-bg);
}
