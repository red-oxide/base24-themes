# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# Color settings for applications, as Nix attrsets in each program's own
# settings format. Each takes a theme; base24's bright colors (base12–base17)
# go where a program has bright or diagnostic colors, so a Base16 theme gets
# the usual base16 ones through the fallbacks.
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
      active_tab_background = c.base02;
      active_tab_foreground = c.base05;
      inactive_tab_background = c.base01;
      inactive_tab_foreground = c.base04;
      tab_bar_background = c.base01;

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
      "constant.character.escape" = c.base0C;
      "constant.numeric" = c.base09;
      "constructor" = c.base0D;
      "debug" = c.base03;
      "diagnostic".modifiers = [ "underlined" ];
      "diagnostic.error" = curl c.base12;
      "diagnostic.hint" = curl c.base15;
      "diagnostic.info" = curl c.base16;
      "diagnostic.warning" = curl c.base13;
      "diff.delta" = c.base09;
      "diff.minus" = c.base08;
      "diff.plus" = c.base0B;
      "error" = c.base12;
      "function" = c.base0D;
      "hint" = c.base15;
      "info" = c.base16;
      "keyword" = c.base0E;
      "label" = c.base0E;
      "namespace" = c.base0E;
      "operator" = c.base05;
      "special" = c.base0D;
      "string" = c.base0B;
      "type" = c.base0A;
      "variable" = c.base08;
      "variable.other.member" = c.base0B;
      "warning" = c.base13;

      "markup.bold" = {
        fg = c.base0A;
        modifiers = [ "bold" ];
      };
      "markup.heading" = c.base0D;
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
        bg = c.base00;
      };
      "ui.bufferline.active" = {
        fg = c.base00;
        bg = c.base03;
        modifiers = [ "bold" ];
      };
      "ui.cursor" = reversed c.base04;
      "ui.cursor.insert" = reversed c.base0A;
      "ui.cursor.match" = reversed c.base0A;
      "ui.cursor.select" = reversed c.base0A;
      "ui.cursorline.primary" = {
        fg = c.base05;
        bg = c.base01;
      };
      "ui.gutter" = bg;
      "ui.help" = {
        fg = c.base06;
        bg = c.base01;
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
        bg = c.base01;
      };
      "ui.menu.scroll" = {
        fg = c.base03;
        bg = c.base01;
      };
      "ui.menu.selected" = {
        fg = c.base01;
        bg = c.base04;
      };
      "ui.popup".bg = c.base01;
      "ui.selection".bg = c.base02;
      "ui.selection.primary".bg = c.base02;
      "ui.statusline" = {
        fg = c.base04;
        bg = c.base01;
      };
      "ui.statusline.inactive" = {
        fg = c.base03;
        bg = c.base01;
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
      "ui.virtual.ruler".bg = c.base01;
      "ui.virtual.whitespace" = c.base02;
      "ui.window".bg = c.base01;
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
      statusbar-bg = solid "base02";
      inputbar-bg = solid "base00";
      inputbar-fg = solid "base07";
      notification-bg = solid "base00";
      notification-fg = solid "base07";
      notification-error-bg = solid "base00";
      notification-error-fg = solid "base12";
      notification-warning-bg = solid "base00";
      notification-warning-fg = solid "base13";
      highlight-color = alpha "base0A" 0.5;
      highlight-active-color = alpha "base0D" 0.5;
      completion-bg = solid "base01";
      completion-fg = solid "base0D";
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
      osd-back-color = c.base01;
      osd-border-color = c.base01;
      osd-color = c.base05;
      osd-shadow-color = c.base00;
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
          bg = c.base0A;
        };
        count_copied = {
          fg = c.base00;
          bg = c.base0B;
        };
        count_cut = {
          fg = c.base00;
          bg = c.base08;
        };
      };
    };

  # niri `layout` settings: the focus ring and window borders.
  niri =
    theme:
    let
      c = hex theme;
    in
    {
      focus-ring = {
        active-color = c.base0D;
        inactive-color = c.base03;
      };
      border = {
        active-color = c.base0D;
        inactive-color = c.base03;
        urgent-color = c.base12;
      };
    };
}
