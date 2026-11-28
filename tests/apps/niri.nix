# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  base24,
  theme,
  hex,
  ...
}:

let
  niri = base24.apps.niri theme;
in
{
  colors =
    niri.border.active-color == hex "base0D"
    && niri.focus-ring.active-color == hex "base16"
    && niri.insert-hint.color == "${hex "base16"}80";
}
