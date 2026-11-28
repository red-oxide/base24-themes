# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  base24,
  theme,
  hex,
  ...
}:

let
  helix = base24.apps.helix { inherit theme; };
  clear = base24.apps.helix {
    inherit theme;
    transparent = true;
  };
in
{
  colors =
    helix."ui.background".bg == hex "base00"
    && helix.keyword == hex "base0E"
    && helix."ui.popup".bg == hex "base10"
    && helix."ui.window".bg == hex "base11"
    && helix."function.builtin" == hex "base16";

  transparent = clear."ui.background" == { } && !(clear."ui.gutter" ? bg);
}
