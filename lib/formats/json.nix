# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# The theme metadata plus a `palette` attrset, as JSON.
{ core, ... }:

let
  inherit (core) getMeta getColors;
in
theme: builtins.toJSON (getMeta theme // { palette = getColors theme; })
