# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  base24,
  theme,
  hex,
  ...
}:

let
  kitty = base24.apps.kitty theme;
in
{
  # The ANSI palette, with base24's bright colors (base12–base17).
  palette =
    kitty.background == hex "base00"
    && kitty.color1 == hex "base08"
    && kitty.color9 == hex "base12"
    && kitty.color15 == hex "base07";

  # The darker backgrounds and the bright accents are used too.
  base24 = kitty.tab_bar_background == hex "base11" && kitty.inactive_tab_background == hex "base10";
}
