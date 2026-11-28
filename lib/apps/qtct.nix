# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# A qt5ct / qt6ct color scheme (qt6ct/colors/<name>.conf), as an attrset for
# `lib.generators.toINI`. It sets the whole QPalette, so Qt's Fusion style
# draws every widget in the theme's colors.
#
# Each line lists the palette's color roles in QPalette::ColorRole order. The
# last one, Accent, is new in Qt 6.6; qt5ct and older Qt 6 read the first 21.
# Content (Base) is base00, the window around it base10 and the bevels base01,
# base02, base10 and base11; disabled text is base03.
{ lib, hex, ... }:

theme:
let
  c = hex theme;
  argb = color: "#ff${lib.removePrefix "#" color}";

  active = {
    WindowText = c.base05;
    Button = c.base01;
    Light = c.base02;
    Midlight = c.base01;
    Dark = c.base11;
    Mid = c.base10;
    Text = c.base05;
    BrightText = c.base07;
    ButtonText = c.base05;
    Base = c.base00;
    Window = c.base10;
    Shadow = c.base11;
    Highlight = c.base0D;
    HighlightedText = c.base00;
    Link = c.base0D;
    LinkVisited = c.base0E;
    AlternateBase = c.base01;
    NoRole = c.base00;
    ToolTipBase = c.base10;
    ToolTipText = c.base05;
    PlaceholderText = c.base03;
    Accent = c.base0D;
  };

  disabled = active // {
    WindowText = c.base03;
    Text = c.base03;
    ButtonText = c.base03;
    Highlight = c.base02;
    HighlightedText = c.base03;
    Link = c.base03;
    LinkVisited = c.base03;
    Accent = c.base02;
  };

  roles = [
    "WindowText"
    "Button"
    "Light"
    "Midlight"
    "Dark"
    "Mid"
    "Text"
    "BrightText"
    "ButtonText"
    "Base"
    "Window"
    "Shadow"
    "Highlight"
    "HighlightedText"
    "Link"
    "LinkVisited"
    "AlternateBase"
    "NoRole"
    "ToolTipBase"
    "ToolTipText"
    "PlaceholderText"
    "Accent"
  ];
  line = group: lib.concatMapStringsSep ", " (role: argb group.${role}) roles;
in
{
  ColorScheme = {
    active_colors = line active;
    inactive_colors = line active;
    disabled_colors = line disabled;
  };
}
