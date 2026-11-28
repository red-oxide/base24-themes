# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# Color settings for applications, as Nix attrsets in each program's own
# settings format, one file per program (lib/apps/<app>.nix). Each takes a
# theme and uses all 24 colors:
#   base10, base11  darker backgrounds, for chrome around the content (popups,
#                   menus, inactive tabs and status bars)
#   base12–base17   bright accents (red, yellow, green, cyan, blue, magenta),
#                   for bright ANSI colors, diagnostics, headings, built-ins
#                   and focus indicators
# A Base16 theme gets base00 and the regular accents through the fallbacks.
#
# Adding a program is adding a file here: every other .nix file in this
# directory becomes `apps.<name>`.
{ lib, core }:

let
  helpers = {
    inherit lib core;

    # { base00 = "#rrggbb"; ... }
    hex = theme: lib.mapAttrs (_: c: "#${c}") (core.getColors theme);

    # "r, g, b" (0–255), for rgb()/rgba().
    rgb =
      theme: name:
      let
        c = core.getColor theme name;
        channel = i: toString (lib.fromHexString (builtins.substring i 2 c));
      in
      "${channel 0}, ${channel 2}, ${channel 4}";
  };

  files = lib.filterAttrs (
    name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
  ) (builtins.readDir ./.);
in
lib.mapAttrs' (
  file: _: lib.nameValuePair (lib.removeSuffix ".nix" file) (import ./${file} helpers)
) files
