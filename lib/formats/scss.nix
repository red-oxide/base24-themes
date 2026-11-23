# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# SCSS variables, one per color: `$base00: #0b0b0b;`.
{ lib, core, ... }:

let
  inherit (core) colorNames normalizeTheme;
in
theme:
let
  normalized = normalizeTheme theme;
in
lib.concatMapStrings (name: "$" + name + ": #" + normalized.${name} + ";\n") colorNames
