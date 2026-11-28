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
  gtk = base24.apps.gtk theme;
  light = base24.apps.gtk (theme // { variant = "light"; });
  bare = lib.removePrefix "#";
in
{
  colors =
    gtk.colors.window-bg-color == hex "base00"
    && gtk.colors.accent-bg-color == hex "base0D"
    && gtk.colors.accent-color == hex "base16"
    && gtk.colors.headerbar-bg-color == hex "base10"
    && gtk.colors.secondary-sidebar-bg-color == hex "base11";

  # The palette's lighter shades are the bright accents on a dark theme and
  # the regular ones on a light theme.
  palette =
    gtk.colors.blue-1 == hex "base16"
    && gtk.colors.blue-5 == hex "base0D"
    && light.colors.blue-1 == hex "base0D"
    && light.colors.blue-5 == hex "base16";

  shades =
    gtk.colors.shade-color == "rgba(0, 0, 6, 0.25)"
    && light.colors.shade-color == "rgba(0, 0, 6, 0.07)";

  gtk4 =
    lib.hasPrefix ":root {" gtk.css.gtk4
    && lib.hasInfix "  --accent-bg-color: ${hex "base0D"};" gtk.css.gtk4;

  gtk3 =
    lib.hasInfix "@define-color accent_bg_color ${hex "base0D"};" gtk.css.gtk3
    && lib.hasInfix "@define-color blue_1 " gtk.css.gtk3
    && !(lib.hasInfix "--" gtk.css.gtk3);

  # Text on every colored background, and the standalone colors on the
  # window, reach 4.5:1 in every bundled theme.
  contrast = lib.all (
    t:
    let
      g = (base24.apps.gtk t).colors;
      ratio = a: b: base24.contrastRatio (bare a) (bare b);
    in
    lib.all
      (
        n: ratio g."${n}-bg-color" g."${n}-fg-color" >= 4.5 && ratio g."${n}-color" g.window-bg-color >= 4.5
      )
      [
        "accent"
        "destructive"
        "success"
        "warning"
        "error"
      ]
  ) (lib.attrValues base24.themes);
}
