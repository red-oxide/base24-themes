# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# GTK and libadwaita colors, as libadwaita's UI and palette colors
# (https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/css-variables.html).
#
#   colors     { accent-bg-color = "#rrggbb"; ... }, keyed by variable name
#   css.gtk4   `:root { --accent-bg-color: ...; }` for gtk-4.0/gtk.css. Current
#              libadwaita (1.6 and later) and adw-gtk3's GTK 4 theme read these.
#   css.gtk3   `@define-color accent_bg_color ...;` for adw-gtk3's GTK 3 theme,
#              which uses libadwaita's colors under their older names
#
# The window and content use base00, the chrome around them (header bars,
# sidebars, popovers, dialogs) base10 and base11, and the bright accents
# base12–base17 the standalone colors (accent text, links, error text). The
# palette's lighter shades (-1, -2) get the bright accents on a dark theme and
# the regular ones on a light theme, where the bright accents are deeper.
# Shades and borders are libadwaita's own for the theme's variant.
{
  lib,
  core,
  hex,
  ...
}:

theme:
let
  c = hex theme;
  dark = (core.getMeta theme).variant == "dark";
  byVariant = light: darkValue: if dark then darkValue else light;
  # alpha as a string: toString on a float gives six decimals.
  shade = alpha: "rgba(0, 0, 6, ${alpha})";

  # Five shades of one hue, lightest first.
  ramp =
    regular: bright:
    let
      lighter = byVariant regular bright;
      darker = byVariant bright regular;
    in
    [
      lighter
      lighter
      regular
      darker
      darker
    ];
  palette =
    lib.concatMapAttrs
      (hue: shades: lib.listToAttrs (lib.imap1 (i: lib.nameValuePair "${hue}-${toString i}") shades))
      {
        blue = ramp c.base0D c.base16;
        green = ramp c.base0B c.base14;
        yellow = ramp c.base0A c.base13;
        orange = ramp c.base09 c.base09;
        red = ramp c.base08 c.base12;
        purple = ramp c.base0E c.base17;
        brown = ramp c.base0F c.base0F;
      };

  # A background, its foreground and (for the colored ones) the standalone
  # color for text on a neutral background.
  pair = name: bg: fg: {
    "${name}-bg-color" = bg;
    "${name}-fg-color" = fg;
  };
  colored =
    name: bg: standalone:
    pair name bg c.base00 // { "${name}-color" = standalone; };

  colors =
    colored "accent" c.base0D c.base16
    // colored "destructive" c.base08 c.base12
    // colored "success" c.base0B c.base14
    // colored "warning" c.base0A c.base13
    // colored "error" c.base08 c.base12
    // pair "window" c.base00 c.base05
    // pair "view" c.base00 c.base05
    // pair "headerbar" c.base10 c.base05
    // {
      headerbar-border-color = c.base05;
      headerbar-backdrop-color = c.base00;
      headerbar-shade-color = shade (byVariant "0.12" "0.36");
      headerbar-darker-shade-color = shade (byVariant "0.12" "0.9");
    }
    // pair "sidebar" c.base10 c.base05
    // {
      sidebar-backdrop-color = c.base00;
      sidebar-border-color = shade (byVariant "0.07" "0.36");
      sidebar-shade-color = shade (byVariant "0.07" "0.25");
    }
    // pair "secondary-sidebar" c.base11 c.base05
    // {
      secondary-sidebar-backdrop-color = c.base10;
      secondary-sidebar-border-color = shade (byVariant "0.07" "0.36");
      secondary-sidebar-shade-color = shade (byVariant "0.07" "0.25");
    }
    // pair "card" c.base01 c.base05
    // {
      card-shade-color = shade (byVariant "0.07" "0.36");
    }
    // pair "overview" c.base10 c.base05
    // pair "thumbnail" c.base01 c.base05
    // pair "active-toggle" c.base02 c.base05
    // pair "dialog" c.base10 c.base05
    // pair "popover" c.base10 c.base05
    // {
      popover-shade-color = shade (byVariant "0.07" "0.25");
      shade-color = shade (byVariant "0.07" "0.25");
      scrollbar-outline-color = c.base00;
    }
    // palette;

  names = lib.attrNames colors;
in
{
  inherit colors;

  css = {
    gtk4 = ":root {\n${lib.concatMapStrings (n: "  --${n}: ${colors.${n}};\n") names}}\n";
    gtk3 = lib.concatMapStrings (
      n: "@define-color ${lib.replaceStrings [ "-" ] [ "_" ] n} ${colors.${n}};\n"
    ) names;
  };
}
