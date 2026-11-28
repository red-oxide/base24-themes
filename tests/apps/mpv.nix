# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  base24,
  theme,
  hex,
  ...
}:

{
  colors = (base24.apps.mpv theme).osd-color == hex "base05";
}
