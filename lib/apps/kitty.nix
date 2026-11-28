# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# kitty.conf settings: the terminal palette, so programs that use the
# terminal's 16 colors (bat's `base16` theme, Helix's `base16_terminal`)
# follow it.
{ hex, ... }:

theme:
let
  c = hex theme;
in
{
  background = c.base00;
  foreground = c.base05;
  cursor = c.base05;
  cursor_text_color = c.base00;
  selection_background = c.base02;
  selection_foreground = c.base05;
  url_color = c.base0D;
  active_border_color = c.base0D;
  inactive_border_color = c.base03;
  active_tab_background = c.base0D;
  active_tab_foreground = c.base00;
  inactive_tab_background = c.base10;
  inactive_tab_foreground = c.base04;
  tab_bar_background = c.base11;
  bell_border_color = c.base13;
  mark1_background = c.base16;
  mark2_background = c.base14;
  mark3_background = c.base17;
  mark1_foreground = c.base00;
  mark2_foreground = c.base00;
  mark3_foreground = c.base00;

  color0 = c.base00;
  color1 = c.base08;
  color2 = c.base0B;
  color3 = c.base0A;
  color4 = c.base0D;
  color5 = c.base0E;
  color6 = c.base0C;
  color7 = c.base05;
  color8 = c.base03;
  color9 = c.base12;
  color10 = c.base14;
  color11 = c.base13;
  color12 = c.base16;
  color13 = c.base17;
  color14 = c.base15;
  color15 = c.base07;
}
