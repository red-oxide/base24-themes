# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{ base24, ... }:

{
  apply = theme: _: { settings.layout = base24.apps.niri theme; };
}
