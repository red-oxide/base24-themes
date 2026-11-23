# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  name = "Blue Crab";
  author = "chrisppy";
  variant = "dark";
  # The Chesapeake Bay: a teal crab with orange claws, Maryland flag red and
  #   gold, and deep bay water for the background.
  # Every accent from base08 to base0F reaches at least 4.5:1 contrast on base00
  # and base01.

  base00 = "08161a"; # Deep bay — primary background
  base01 = "0f2026"; # Deep bay — panels / secondary background
  base02 = "1d353d"; # Bay teal — selection / highlighted background
  base03 = "35525b"; # Murky teal — comments / inactive elements
  base04 = "83a0a6"; # Sea mist — muted foreground
  base05 = "dfe8e6"; # Foam white — primary foreground
  base06 = "edf3f1"; # Bright foam — bright foreground
  base07 = "fafdfc"; # White — maximum contrast
  base08 = "ed5a3b"; # Maryland red — variables / errors
  base09 = "f2802a"; # Claw orange — numbers / constants
  base0A = "e6b450"; # Maryland gold — classes / warnings
  base0B = "6fbf8e"; # Bay grass — strings / success
  base0C = "3fc2c0"; # Crab teal — support / escapes
  base0D = "7fb0e6"; # Chesapeake blue — functions / links
  base0E = "d48bb0"; # Oyster pink — keywords
  base0F = "b59a7a"; # Crab spice — deprecated / embedded

  # Base24 extensions
  base10 = "051014"; # Deep bay — darker background
  base11 = "020a0c"; # Deep bay — darkest background
  base12 = "ff7556"; # Bright Maryland red — bright red
  base13 = "f7cb6e"; # Bright Maryland gold — bright yellow
  base14 = "8ad6a6"; # Bright bay grass — bright green
  base15 = "66d9d6"; # Bright crab teal — bright cyan
  base16 = "9cc6f2"; # Bright Chesapeake blue — bright blue
  base17 = "e5a6c6"; # Bright oyster pink — bright magenta
}
