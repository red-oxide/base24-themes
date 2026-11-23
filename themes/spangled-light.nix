# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  name = "Spangled Light";
  author = "chrisppy";
  variant = "light";
  # The light counterpart of Spangled; accents are deepened to stay readable.
  # Every accent from base08 to base0F reaches at least 4.5:1 contrast on base00
  # and base01.

  base00 = "f4f1ea"; # Cream — primary background
  base01 = "ebe7de"; # Darker cream — panels / secondary background
  base02 = "dcd7cb"; # Tan — selection / highlighted background
  base03 = "a29d93"; # Warm gray — comments / inactive elements
  base04 = "686459"; # Slate — muted foreground
  base05 = "1c2030"; # Night navy — primary foreground
  base06 = "121522"; # Night navy — bright foreground
  base07 = "0b0d14"; # Night navy — maximum contrast
  base08 = "c0250d"; # Deep firework red — variables / errors
  base09 = "ae4203"; # Deep ballpark orange — numbers / constants
  base0A = "865d02"; # Deep firework gold — classes / warnings
  base0B = "4b6e33"; # Deep outfield green — strings / success
  base0C = "276c85"; # Deep star blue — support / escapes
  base0D = "2f5dcc"; # Deep evening blue — functions / links
  base0E = "ac3185"; # Deep firework pink — keywords
  base0F = "795f36"; # Deep brass key — deprecated / embedded

  # Base24 extensions
  base10 = "efebe3"; # Darker cream — darker background
  base11 = "e9e5dc"; # Darkest cream — darkest background
  base12 = "ad210c"; # Intense firework red — bright red
  base13 = "775302"; # Intense firework gold — bright yellow
  base14 = "43622e"; # Intense outfield green — bright green
  base15 = "236075"; # Intense star blue — bright cyan
  base16 = "2a53b6"; # Intense evening blue — bright blue
  base17 = "9a2c77"; # Intense firework pink — bright magenta
}
