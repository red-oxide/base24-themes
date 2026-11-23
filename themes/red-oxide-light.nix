# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  name = "Red Oxide Light";
  author = "chrisppy";
  variant = "light";
  # The light counterpart of Red Oxide; accents are deepened to stay readable.
  # Every accent from base08 to base0F reaches at least 4.5:1 contrast on base00
  # and base01.

  base00 = "f3f2ef"; # Plate white — primary background
  base01 = "e9e7e2"; # Primer white — panels / secondary background
  base02 = "d9d5ce"; # Light scale — selection / highlighted background
  base03 = "a19891"; # Weathered gray — comments / inactive elements
  base04 = "675d58"; # Corroded gray — muted foreground
  base05 = "2a1c18"; # Dark oxide — primary foreground
  base06 = "1c120f"; # Dark oxide — bright foreground
  base07 = "120b09"; # Dark oxide — maximum contrast
  base08 = "9a3b26"; # Oxide red (logo) — variables / errors
  base09 = "a34a0e"; # Deep rust orange — numbers / constants
  base0A = "805d18"; # Deep brass — classes / warnings
  base0B = "456d47"; # Deep patina green — strings / success
  base0C = "2f6d64"; # Deep verdigris — support / escapes
  base0D = "436596"; # Deep blued steel — functions / links
  base0E = "a3454c"; # Deep rose rust — keywords
  base0F = "7a5e47"; # Deep mill scale — deprecated / embedded

  # Base24 extensions
  base10 = "eeece8"; # Primer white — darker background
  base11 = "e8e5e0"; # Primer white — darkest background
  base12 = "5a2216"; # Dark oxide (logo) — bright red
  base13 = "735415"; # Intense brass — bright yellow
  base14 = "3e623f"; # Intense patina — bright green
  base15 = "2a635a"; # Intense verdigris — bright cyan
  base16 = "3c5b86"; # Intense blued steel — bright blue
  base17 = "933e45"; # Intense rose rust — bright magenta
}
