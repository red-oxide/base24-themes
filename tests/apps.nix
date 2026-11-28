# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# Application color settings (lib/apps.nix).
{
  lib,
  base24,
  fixtures,
  ...
}:

let
  inherit (fixtures) base16Theme;
  colors = base24.getColors base16Theme;
  hex = name: "#${colors.${name}}";
  kitty = base24.apps.kitty base16Theme;
  helix = base24.apps.helix { theme = base16Theme; };
  clearHelix = base24.apps.helix {
    theme = base16Theme;
    transparent = true;
  };
  zathura = base24.apps.zathura { theme = base16Theme; };
in
{
  # The ANSI palette, with base24's bright colors (base12–base17).
  kitty =
    kitty.background == hex "base00"
    && kitty.color1 == hex "base08"
    && kitty.color9 == hex "base12"
    && kitty.color15 == hex "base07";

  # The darker backgrounds and the bright accents are used too.
  kittyBase24 = kitty.tab_bar_background == hex "base11" && kitty.inactive_tab_background == hex "base10";

  helix =
    helix."ui.background".bg == hex "base00"
    && helix.keyword == hex "base0E"
    && helix."ui.popup".bg == hex "base10"
    && helix."ui.window".bg == hex "base11"
    && helix."function.builtin" == hex "base16";

  helixTransparent = clearHelix."ui.background" == { } && !(clearHelix."ui.gutter" ? bg);

  zathura =
    lib.hasPrefix "rgba(" zathura.default-bg
    && lib.hasPrefix "rgb(" zathura.statusbar-bg
    && !(lib.hasInfix "#" zathura.statusbar-bg);

  niri =
    let
      niri = base24.apps.niri base16Theme;
    in
    niri.border.active-color == hex "base0D"
    && niri.focus-ring.active-color == hex "base16"
    && niri.insert-hint.color == "${hex "base16"}80";

  mpv = (base24.apps.mpv base16Theme).osd-color == hex "base05";

  yazi = (base24.apps.yazi base16Theme).mgr.cwd.fg == hex "base0C";
}
