# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  name = "Eastern Shore";
  author = "chrisppy";
  variant = "dark";
  # Salisbury and the Eastern Shore of Maryland: black, silver and orange,
  #   with beach sand, marsh grass and bay water for the remaining accents.
  # Every accent from base08 to base0F reaches at least 4.5:1 contrast on base00
  # and base01.

  base00 = "0c0c0c"; # Black — primary background
  base01 = "161616"; # Black — panels / secondary background
  base02 = "2a2a2a"; # Dark gray — selection / highlighted background
  base03 = "4a4a4a"; # Gray — comments / inactive elements
  base04 = "9a9a9a"; # Silver — muted foreground
  base05 = "dcdcdc"; # Light silver — primary foreground
  base06 = "ececec"; # Bright silver — bright foreground
  base07 = "fafafa"; # White — maximum contrast
  base08 = "e3561c"; # Orange — variables / errors
  base09 = "f2802e"; # Light orange — numbers / constants
  base0A = "d9bf86"; # Beach sand — classes / warnings
  base0B = "8aa864"; # Marsh grass — strings / success
  base0C = "7fb3b8"; # Bay water — support / escapes
  base0D = "8fa8c4"; # Shore sky — functions / links
  base0E = "c48a8a"; # Sunset pink — keywords
  base0F = "a8a39a"; # Driftwood — deprecated / embedded

  # Base24 extensions
  base10 = "070707"; # Black — darker background
  base11 = "030303"; # Black — darkest background
  base12 = "ff6a2a"; # Bright orange — bright red
  base13 = "ecd29c"; # Bright sand — bright yellow
  base14 = "a2c07c"; # Bright marsh grass — bright green
  base15 = "9ccbd0"; # Bright bay water — bright cyan
  base16 = "a9c0da"; # Bright shore sky — bright blue
  base17 = "d8a2a2"; # Bright sunset pink — bright magenta
}
