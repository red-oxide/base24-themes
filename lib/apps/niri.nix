# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# niri `layout` settings: the focus ring, window borders, tab indicator
# and insert hint.
{ hex, ... }:

theme:
let
  c = hex theme;
in
{
  focus-ring = {
    active-color = c.base16;
    inactive-color = c.base03;
    urgent-color = c.base12;
  };
  border = {
    active-color = c.base0D;
    inactive-color = c.base03;
    urgent-color = c.base12;
  };
  tab-indicator = {
    active-color = c.base16;
    inactive-color = c.base03;
    urgent-color = c.base12;
  };
  # Translucent, as niri's default.
  insert-hint.color = "${c.base16}80";
}
