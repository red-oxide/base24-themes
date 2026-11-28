# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  lib,
  base24,
  theme,
  hex,
  ...
}:

let
  scheme = (base24.apps.qtct theme).ColorScheme;
  roles = line: map lib.trim (lib.splitString "," line);
  argb = name: "#ff${lib.removePrefix "#" (hex name)}";
  active = roles scheme.active_colors;
  disabled = roles scheme.disabled_colors;
in
{
  # Every QPalette role, Accent (Qt 6.6) included, in each group.
  roles = lib.all (line: builtins.length (roles line) == 22) (lib.attrValues scheme);

  colors =
    builtins.elemAt active 0 == argb "base05" # WindowText
    && builtins.elemAt active 9 == argb "base00" # Base
    && builtins.elemAt active 10 == argb "base10" # Window
    && builtins.elemAt active 12 == argb "base0D" # Highlight
    && builtins.elemAt disabled 0 == argb "base03";
}
