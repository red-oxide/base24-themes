# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# docs/gallery.md: every bundled theme's card, two to a row (so each dark
# theme sits beside its light variant) at the cards' native width, each
# linking to docs/<name>.md. Regenerate with:
#   nix eval --raw .#lib.base24.gallery > docs/gallery.md
{
  lib,
  core,
  themes,
}:

let
  names = builtins.attrNames themes;

  # Cards per row, and their width in px (the card SVGs are drawn at 392).
  perRow = 2;
  cardWidth = 392;

  cell =
    name:
    let
      title = lib.escapeXML (core.getMeta themes.${name}).name;
    in
    ''
      <td align="center" valign="top">
      <a href="./${name}.md"><img src="../previews/cards/${name}.svg" alt="${title}" width="${toString cardWidth}"></a><br>
      <a href="./${name}.md"><strong>${title}</strong></a>
      </td>
    '';

  rows = lib.genList (i: lib.sublist (i * perRow) perRow names) (
    (builtins.length names + perRow - 1) / perRow
  );
  row = cells: "<tr>\n" + lib.concatMapStrings cell cells + "</tr>\n";
in
''
  ## Gallery

  Every bundled theme at a glance. Select one for its full palette.

  <table>
  ${lib.concatMapStrings row rows}</table>

  This page is generated: run
  `nix eval --raw .#lib.base24.gallery > docs/gallery.md` after adding a theme.
''
