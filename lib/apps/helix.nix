# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# A Helix theme (themes/<name>.toml), mapped as base16-helix does. With
# `transparent`, the editor leaves the background to the terminal.
{ lib, hex, ... }:

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
}
