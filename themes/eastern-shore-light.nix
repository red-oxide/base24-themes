# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  name = "Eastern Shore Light";
  author = "chrisppy";
  variant = "light";
  # The light counterpart of Eastern Shore; accents are deepened to stay readable.
  # Every accent from base08 to base0F reaches at least 4.5:1 contrast on base00
  # and base01.

  base00 = "f2f2f0"; # Silver white — primary background
  base01 = "e9e9e6"; # Light silver — panels / secondary background
  base02 = "d9d9d5"; # Silver — selection / highlighted background
  base03 = "9d9d98"; # Gray — comments / inactive elements
  base04 = "636360"; # Dark gray — muted foreground
  base05 = "222222"; # Charcoal — primary foreground
  base06 = "151515"; # Black — bright foreground
  base07 = "0c0c0c"; # Black — maximum contrast
  base08 = "b23d0e"; # Deep orange — variables / errors
  base09 = "a84802"; # Deep amber — numbers / constants
  base0A = "7e6122"; # Deep beach sand — classes / warnings
  base0B = "556b38"; # Deep marsh grass — strings / success
  base0C = "3b6d72"; # Deep bay water — support / escapes
  base0D = "46688e"; # Deep shore sky — functions / links
  base0E = "a04b4b"; # Deep sunset pink — keywords
  base0F = "6b655a"; # Deep driftwood — deprecated / embedded

  # Base24 extensions
  base10 = "ededea"; # Light silver — darker background
  base11 = "e7e7e4"; # Light silver — darkest background
  base12 = "9f370c"; # Intense orange — bright red
  base13 = "70561e"; # Intense sand — bright yellow
  base14 = "4d6133"; # Intense marsh grass — bright green
  base15 = "346065"; # Intense bay water — bright cyan
  base16 = "3e5c7e"; # Intense shore sky — bright blue
  base17 = "904343"; # Intense sunset pink — bright magenta
}
