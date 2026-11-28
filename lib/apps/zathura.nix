# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# zathurarc options, mapped as base16-zathura does. `opacity` applies to
# the page background.
{ rgb, ... }:

{
  theme,
  opacity ? 1.0,
}:
let
  color = rgb theme;
  solid = name: "rgb(${color name})";
  alpha = name: a: "rgba(${color name}, ${toString a})";
in
{
  default-bg = alpha "base00" opacity;
  default-fg = solid "base01";
  statusbar-fg = solid "base04";
  statusbar-bg = solid "base10";
  inputbar-bg = solid "base11";
  inputbar-fg = solid "base07";
  notification-bg = solid "base10";
  notification-fg = solid "base07";
  notification-error-bg = solid "base10";
  notification-error-fg = solid "base12";
  notification-warning-bg = solid "base10";
  notification-warning-fg = solid "base13";
  highlight-color = alpha "base0A" 0.5;
  highlight-active-color = alpha "base16" 0.5;
  highlight-fg = solid "base00";
  completion-bg = solid "base10";
  completion-fg = solid "base0D";
  completion-group-bg = solid "base11";
  completion-group-fg = solid "base15";
  index-bg = solid "base10";
  index-fg = solid "base05";
  index-active-bg = solid "base0D";
  index-active-fg = solid "base00";
  completion-highlight-fg = solid "base07";
  completion-highlight-bg = solid "base0D";
  recolor-lightcolor = solid "base00";
  recolor-darkcolor = solid "base06";
}
