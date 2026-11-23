# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  name = "Red Oxide";
  author = "chrisppy";
  variant = "dark";
  # red-oxide: a rusted steel home plate. Oxide red and rust orange on dark
  #   rusted steel, plate-white text, with brass, patina and blued steel for
  #   the remaining accents.
  # Every accent from base08 to base0F reaches at least 4.5:1 contrast on base00
  # and base01.

  base00 = "14100f"; # Rusted steel — primary background
  base01 = "1d1716"; # Rusted steel — panels / secondary background
  base02 = "332926"; # Scale — selection / highlighted background
  base03 = "54453f"; # Corroded gray — comments / inactive elements
  base04 = "9a8a82"; # Weathered steel — muted foreground
  base05 = "e8e4dd"; # Plate white — primary foreground
  base06 = "f3f2ef"; # Plate white — bright foreground
  base07 = "fbfaf8"; # White — maximum contrast
  base08 = "dc5a3e"; # Oxide red — variables / errors
  base09 = "e5823f"; # Rust orange — numbers / constants
  base0A = "d6a94e"; # Brass — classes / warnings
  base0B = "82ad84"; # Patina green — strings / success
  base0C = "6fbcb0"; # Verdigris — support / escapes
  base0D = "8ea6c8"; # Blued steel — functions / links
  base0E = "c98a8f"; # Rose rust — keywords
  base0F = "b49a85"; # Mill scale — deprecated / embedded

  # Base24 extensions
  base10 = "0e0b0a"; # Rusted steel — darker background
  base11 = "080605"; # Rusted steel — darkest background
  base12 = "f0705a"; # Bright oxide red — bright red
  base13 = "ebc46c"; # Bright brass — bright yellow
  base14 = "9cc69e"; # Bright patina — bright green
  base15 = "8ed4c8"; # Bright verdigris — bright cyan
  base16 = "a9bede"; # Bright blued steel — bright blue
  base17 = "dca5a9"; # Bright rose rust — bright magenta
}
