# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# yazi theme.toml settings for the file list and markers.
{ hex, ... }:

theme:
let
  c = hex theme;
  both = color: {
    fg = color;
    bg = color;
  };
in
{
  mgr = {
    cwd.fg = c.base0C;
    border_style.fg = c.base04;
    find_keyword = {
      fg = c.base0B;
      bold = true;
    };
    find_position.fg = c.base0E;
    marker_selected = both c.base0A;
    marker_copied = both c.base0B;
    marker_cut = both c.base08;
    count_selected = {
      fg = c.base00;
      bg = c.base13;
    };
    count_copied = {
      fg = c.base00;
      bg = c.base14;
    };
    count_cut = {
      fg = c.base00;
      bg = c.base12;
    };
  };
  tabs = {
    active = {
      fg = c.base00;
      bg = c.base0D;
      bold = true;
    };
    inactive = {
      fg = c.base04;
      bg = c.base10;
    };
  };
  mode = {
    normal_main = {
      fg = c.base00;
      bg = c.base0D;
      bold = true;
    };
    normal_alt = {
      fg = c.base0D;
      bg = c.base10;
    };
    select_main = {
      fg = c.base00;
      bg = c.base17;
      bold = true;
    };
    select_alt = {
      fg = c.base17;
      bg = c.base10;
    };
    unset_main = {
      fg = c.base00;
      bg = c.base15;
      bold = true;
    };
    unset_alt = {
      fg = c.base15;
      bg = c.base10;
    };
  };
}
