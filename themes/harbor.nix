# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  name = "Harbor";
  author = "chrisppy";
  variant = "dark";
  # Norfolk, Virginia, and its naval harbor: battleship gray, sea foam, tidal
  #   green, orange and black.
  # Every accent from base08 to base0F reaches at least 4.5:1 contrast on base00
  # and base01.

  base00 = "15191b"; # Battleship gray — primary background
  base01 = "1e2326"; # Battleship gray — panels / secondary background
  base02 = "31383c"; # Deck gray — selection / highlighted background
  base03 = "4f585d"; # Hull gray — comments / inactive elements
  base04 = "96a0a4"; # Fog gray — muted foreground
  base05 = "dde6e3"; # Sea spray — primary foreground
  base06 = "ebf1ef"; # Bright spray — bright foreground
  base07 = "f9fcfb"; # White — maximum contrast
  base08 = "ee5a2c"; # Signal orange — variables / errors
  base09 = "f58a3c"; # Buoy orange — numbers / constants
  base0A = "d8c27a"; # Brass — classes / warnings
  base0B = "4fae8a"; # Tidal green — strings / success
  base0C = "8fd8c4"; # Sea foam — support / escapes
  base0D = "7fb0c8"; # Harbor blue — functions / links
  base0E = "c494b8"; # Coral — keywords
  base0F = "a8a49a"; # Rope — deprecated / embedded

  # Base24 extensions
  base10 = "101315"; # Battleship gray — darker background
  base11 = "0a0c0d"; # Battleship gray — darkest background
  base12 = "ff7040"; # Bright signal orange — bright red
  base13 = "ead594"; # Bright brass — bright yellow
  base14 = "6cc8a3"; # Bright tidal green — bright green
  base15 = "a8e8d6"; # Bright sea foam — bright cyan
  base16 = "9cc6db"; # Bright harbor blue — bright blue
  base17 = "d8acc9"; # Bright coral — bright magenta
}
