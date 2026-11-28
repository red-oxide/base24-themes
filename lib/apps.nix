# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# Color settings for applications, as Nix attrsets in each program's own
# settings format. Each takes a theme and uses all 24 colors:
#   base10, base11  darker backgrounds, for chrome around the content (popups,
#                   menus, inactive tabs and status bars)
#   base12–base17   bright accents (red, yellow, green, cyan, blue, magenta),
#                   for bright ANSI colors, diagnostics, headings, built-ins
#                   and focus indicators
# A Base16 theme gets base00 and the regular accents through the fallbacks.
{ lib, core }:

let
  hex = theme: lib.mapAttrs (_: c: "#${c}") (core.getColors theme);
  # "r, g, b" (0–255), for rgb()/rgba().
  rgb =
    theme: name:
    let
      c = core.getColor theme name;
      channel = i: toString (lib.fromHexString (builtins.substring i 2 c));
    in
    "${channel 0}, ${channel 2}, ${channel 4}";
in
{
  # kitty.conf settings: the terminal palette, so programs that use the
  # terminal's 16 colors (bat's `base16` theme, Helix's `base16_terminal`)
  # follow it.
  kitty =
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
    };

  # A Helix theme (themes/<name>.toml), mapped as base16-helix does. With
  # `transparent`, the editor leaves the background to the terminal.
  helix =
    {
      theme,
      transparent ? false,
    }:
    let
      c = hex theme;
      bg = lib.optionalAttrs (!transparent) { bg = c.base00; };
      reversed = fg: {
        inherit fg;
        modifiers = [ "reversed" ];
      };
      curl = color: {
        underline = {
          style = "curl";
          inherit color;
        };
      };
    in
    {
      "attribute" = c.base09;
      "comment" = {
        fg = c.base03;
        modifiers = [ "italic" ];
      };
      "constant" = c.base09;
      "constant.builtin" = c.base17;
      "constant.character.escape" = c.base0C;
      "constant.numeric" = c.base09;
      "constructor" = c.base0D;
      "debug" = c.base03;
      "diagnostic".modifiers = [ "underlined" ];
      "diagnostic.error" = curl c.base12;
      "diagnostic.hint" = curl c.base15;
      "diagnostic.info" = curl c.base16;
      "diagnostic.warning" = curl c.base13;
      "diff.delta" = c.base13;
      "diff.minus" = c.base12;
      "diff.plus" = c.base14;
      "error" = c.base12;
      "function" = c.base0D;
      "function.builtin" = c.base16;
      "hint" = c.base15;
      "info" = c.base16;
      "keyword" = c.base0E;
      "label" = c.base0E;
      "namespace" = c.base0E;
      "operator" = c.base05;
      "punctuation.special" = c.base15;
      "special" = c.base0D;
      "string" = c.base0B;
      "string.special" = c.base14;
      "tag" = c.base08;
      "type" = c.base0A;
      "type.builtin" = c.base13;
      "variable" = c.base08;
      "variable.builtin" = c.base12;
      "variable.other.member" = c.base0B;
      "warning" = c.base13;

      "markup.bold" = {
        fg = c.base0A;
        modifiers = [ "bold" ];
      };
      "markup.heading" = c.base0D;
      "markup.heading.1" = {
        fg = c.base16;
        modifiers = [ "bold" ];
      };
      "markup.heading.2" = {
        fg = c.base15;
        modifiers = [ "bold" ];
      };
      "markup.heading.3" = c.base14;
      "markup.heading.4" = c.base13;
      "markup.heading.5" = c.base17;
      "markup.heading.6" = c.base12;
      "markup.italic" = {
        fg = c.base0E;
        modifiers = [ "italic" ];
      };
      "markup.link.text" = c.base08;
      "markup.link.url" = {
        fg = c.base09;
        modifiers = [ "underlined" ];
      };
      "markup.list" = c.base08;
      "markup.quote" = c.base0C;
      "markup.raw" = c.base0B;
      "markup.strikethrough".modifiers = [ "crossed_out" ];

      "ui.background" = bg;
      "ui.bufferline" = {
        fg = c.base04;
        bg = c.base10;
      };
      "ui.bufferline.background".bg = c.base11;
      "ui.bufferline.active" = {
        fg = c.base00;
        bg = c.base03;
        modifiers = [ "bold" ];
      };
      "ui.cursor" = reversed c.base04;
      "ui.cursor.insert" = reversed c.base0A;
      "ui.cursor.match" = reversed c.base13;
      "ui.cursor.select" = reversed c.base0A;
      "ui.cursorline.primary" = {
        fg = c.base05;
        bg = c.base01;
      };
      "ui.gutter" = bg;
      "ui.help" = {
        fg = c.base06;
        bg = c.base10;
      };
      "ui.linenr" = {
        fg = c.base03;
      }
      // bg;
      "ui.linenr.selected" = {
        fg = c.base04;
        bg = c.base01;
        modifiers = [ "bold" ];
      };
      "ui.menu" = {
        fg = c.base05;
        bg = c.base10;
      };
      "ui.menu.scroll" = {
        fg = c.base03;
        bg = c.base10;
      };
      "ui.menu.selected" = {
        fg = c.base00;
        bg = c.base16;
      };
      "ui.popup".bg = c.base10;
      "ui.popup.info".bg = c.base10;
      "ui.selection".bg = c.base02;
      "ui.selection.primary".bg = c.base02;
      "ui.statusline" = {
        fg = c.base04;
        bg = c.base01;
      };
      "ui.statusline.inactive" = {
        fg = c.base03;
        bg = c.base11;
      };
      "ui.statusline.insert" = {
        fg = c.base00;
        bg = c.base0B;
      };
      "ui.statusline.normal" = {
        fg = c.base00;
        bg = c.base03;
      };
      "ui.statusline.select" = {
        fg = c.base00;
        bg = c.base0F;
      };
      "ui.text" = c.base05;
      "ui.text.focus" = c.base05;
      "ui.virtual.indent-guide" = c.base03;
      "ui.virtual.inlay-hint" = c.base03;
      "ui.virtual.jump-label" = {
        fg = c.base12;
        modifiers = [ "bold" ];
      };
      "ui.virtual.ruler".bg = c.base10;
      "ui.virtual.whitespace" = c.base02;
      "ui.window" = {
        fg = c.base03;
        bg = c.base11;
      };
    };

  # zathurarc options, mapped as base16-zathura does. `opacity` applies to
  # the page background.
  zathura =
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
    };

  # mpv options for the on-screen display (as `--name=value` or mpv.conf).
  mpv =
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
    };

  # yazi theme.toml settings for the file list and markers.
  yazi =
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
    };

  # niri `layout` settings: the focus ring, window borders, tab indicator
  # and insert hint.
  niri =
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
    };
}
