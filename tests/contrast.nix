# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# WCAG luminance and contrast (lib/contrast.nix).
{ base24, ... }:

let
  inherit (base24) contrastRatio luminance;
  # Floats from the lookup table aren't exact; compare to two decimals.
  near =
    expected: actual:
    let
      diff = actual - expected;
    in
    diff < 0.005 && diff > -0.005;
in
{
  luminanceRange = luminance "000000" == 0.0 && luminance "ffffff" == 1.0;

  blackOnWhite = near 21.0 (contrastRatio "000000" "ffffff");
  sameColor = contrastRatio "4f8f6a" "4f8f6a" == 1.0;
  symmetric = contrastRatio "df4601" "0b0b0b" == contrastRatio "0b0b0b" "df4601";

  # Known values: #777777 on white is the classic "just under AA" gray.
  grayOnWhite = near 4.48 (contrastRatio "777777" "ffffff");
  orangeOnBlack = near 4.70 (contrastRatio "df4601" "0b0b0b");
}
