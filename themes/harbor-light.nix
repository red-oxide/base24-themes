# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  name = "Harbor Light";
  author = "chrisppy";
  variant = "light";
  # The light counterpart of Harbor; accents are deepened to stay readable.
  # Every accent from base08 to base0F reaches at least 4.5:1 contrast on base00
  # and base01.

  base00 = "eef1f0"; # Fog — primary background
  base01 = "e4e8e7"; # Light fog — panels / secondary background
  base02 = "d4dad8"; # Haze — selection / highlighted background
  base03 = "979f9c"; # Hull gray — comments / inactive elements
  base04 = "5d6563"; # Deck gray — muted foreground
  base05 = "1e2427"; # Battleship gray — primary foreground
  base06 = "15191b"; # Battleship gray — bright foreground
  base07 = "0d1011"; # Battleship gray — maximum contrast
  base08 = "bb3106"; # Deep signal orange — variables / errors
  base09 = "a74701"; # Deep buoy orange — numbers / constants
  base0A = "75611d"; # Deep brass — classes / warnings
  base0B = "2f7057"; # Deep tidal green — strings / success
  base0C = "226f5a"; # Deep sea foam — support / escapes
  base0D = "346a85"; # Deep harbor blue — functions / links
  base0E = "924c80"; # Deep coral — keywords
  base0F = "686358"; # Deep rope — deprecated / embedded

  # Base24 extensions
  base10 = "e9edec"; # Light fog — darker background
  base11 = "e3e8e6"; # Light fog — darkest background
  base12 = "a72c06"; # Intense signal orange — bright red
  base13 = "69571a"; # Intense brass — bright yellow
  base14 = "29634d"; # Intense tidal green — bright green
  base15 = "1e6350"; # Intense sea foam — bright cyan
  base16 = "2e5e76"; # Intense harbor blue — bright blue
  base17 = "814372"; # Intense coral — bright magenta
}
