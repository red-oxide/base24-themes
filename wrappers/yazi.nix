# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{ base24, ... }:

{
  apply = theme: _: { settings.theme = base24.apps.yazi theme; };
}
