# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# mpv options for the on-screen display (as `--name=value` or mpv.conf).
{ hex, ... }:

theme:
let
  c = hex theme;
in
{
  background-color = "#000000";
  osd-back-color = c.base10;
  osd-border-color = c.base11;
  osd-color = c.base05;
  osd-shadow-color = c.base11;
  osd-selected-color = c.base16;
  osd-selected-outline-color = c.base11;
}
