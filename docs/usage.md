<!--
SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
SPDX-License-Identifier: MIT
-->

## Library

Everything lives at `lib.base24`: the functions, the bundled themes
(`lib.base24.themes.<name>`), their preview images
(`lib.base24.previews.<name>`) and gallery cards (`lib.base24.cards.<name>`),
and the gallery page (`lib.base24.gallery`). It is system-independent.

```nix
let
  base24 = inputs.base24-themes.lib.base24;
  theme = base24.themes.birdland;
in
{
  qml = base24.toQml theme;   # QML singleton
  yaml = base24.toYaml theme; # tinted-theming scheme
  json = base24.toJson theme;
  scss = base24.toScss theme;
  bg = base24.getColorHex theme "base00"; # "#0b0b0b"
}
```

| Function | Returns |
| ------------------------------------------------ | ------------------------------------------------------------------------------ |
| `normalizeTheme theme` | The theme with all 24 colors filled in and lowercased; throws on invalid input |
| `getColors theme` | An attrset of just the 24 colors |
| `getColor theme name` / `getColorHex theme name` | One color, without or with a leading `#` |
| `luminance hex` | WCAG relative luminance of a color, from 0 to 1 |
| `contrastRatio a b` | WCAG contrast ratio between two colors, from 1 to 21 |
| `toYaml`, `toJson`, `toScss`, `toQml` | The theme as a string in that format |
| `toSvg theme` | A preview image: palette swatches plus a highlighted code sample |
| `toCardSvg theme` | A gallery card: code sample, palette strip and system/variant tags |

`toQml` produces a `pragma Singleton` file. Register it in a `qmldir` next to
it, for example `singleton Theme 1.0 Theme.qml`.

The library needs only a nixpkgs `lib`, so it also works without flakes:

```nix
base24 = import "${base24-themes-source}/lib" { inherit (pkgs) lib; };
```

## Defining your own theme

A theme is a flat attrset of `base00`–`base17`, plus optional `name`, `author`
and `variant` (`"dark"` or `"light"`, default `"dark"`). Colors are six hex
digits **without** a leading `#`.

```nix
{
  name = "My Theme";
  author = "me";
  variant = "dark";
  base00 = "181818"; # background
  base01 = "282828";
  base02 = "383838";
  base03 = "585858";
  base04 = "b8b8b8";
  base05 = "d8d8d8"; # foreground
  base06 = "e8e8e8";
  base07 = "f8f8f8";
  base08 = "ab4642"; # red
  base09 = "dc9656"; # orange
  base0A = "f7ca88"; # yellow
  base0B = "a1b56c"; # green
  base0C = "86c1b9"; # cyan
  base0D = "7cafc2"; # blue
  base0E = "ba8baf"; # magenta
  base0F = "a16946"; # brown
  # Base24 extensions
  base10 = "101010"; # darker background (not lighter than base00)
  base11 = "0c0c0c"; # darkest background (not lighter than base10)
  base12 = "d0605c"; # bright red
  base13 = "fbd9a6"; # bright yellow
  base14 = "bbcf88"; # bright green
  base15 = "a3d5cd"; # bright cyan
  base16 = "9cc8da"; # bright blue
  base17 = "d3a9ca"; # bright magenta
}
```

Base16 themes (only `base00`–`base0F`) are accepted too. The missing colors fall
back to `base00` for `base10`/`base11` and to the matching normal color for
`base12`–`base17`.

To bundle a theme, add it as `themes/<name>.nix`. Its key is the file name, and
`name` defaults to it. Bundled themes must define all 24 colors and need a page
at `docs/<name>.md`, a preview image and a gallery card, and the gallery has to
be regenerated:

```sh
nix eval --raw .#lib.base24.previews.<name> > previews/<name>.svg
nix eval --raw .#lib.base24.cards.<name> > previews/cards/<name>.svg
nix eval --raw .#lib.base24.gallery > docs/gallery.md
```

`nix flake check` fails if the page is missing or if any generated file is
missing or out of date.

## NixOS and Home Manager module

The same module is exported as `nixosModules.default` and `homeModules.default`
(also as `homeManagerModules.default`, the older name, which keeps working):

```nix
{ inputs, config, ... }: {
  imports = [ inputs.base24-themes.homeModules.default ];

  base24.theme = "birdland";
  # or: base24.customTheme = { base00 = "181818"; ... };

  # Use the colors anywhere in your configuration:
  # config.lib.base24.colors.base05     -> "d8d8d8"
  # config.lib.base24.getColorHex "base0D"
  # config.lib.base24.qml               -> QML singleton source
}
```

| Option | Default | Description |
| -------------------- | ------------ | --------------------------------------- |
| `base24.enable` | `true` | Expose the theme as `config.lib.base24` |
| `base24.theme` | `"birdland"` | A bundled theme name |
| `base24.customTheme` | `null` | An inline theme; overrides `theme` |

The module only exposes colors. It does not configure any applications itself;
for GTK and Qt apps, see [GTK and Qt apps](#gtk-and-qt-apps).

## Application colors

`lib.base24.apps` has each program's color settings, as a Nix attrset in that
program's own format. They use all 24 colors:

- **base10 and base11**, the darker backgrounds, for chrome around the content:
  popups, menus, inactive tabs and status bars, and the tab bar.
- **base12–base17**, the bright accents, for bright ANSI colors, diagnostics,
  diffs, headings, built-ins and focus indicators (the active tab, the focus
  ring, the selected menu item).

A Base16 theme gets base00 and the regular accents through the fallbacks, so it
looks like a plain base16 mapping.

| Function | Gives |
| ------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `apps.kitty theme` | kitty.conf colors, including the 16-color palette |
| `apps.helix { theme, transparent ? false }` | A Helix theme (`themes/<name>.toml`) |
| `apps.zathura { theme, opacity ? 1.0 }` | zathurarc color options |
| `apps.mpv theme` | mpv options for the on-screen display |
| `apps.yazi theme` | yazi `theme.toml` colors |
| `apps.niri theme` | niri `layout` colors |
| `apps.gtk theme` | libadwaita's colors: `colors`, plus `css.gtk4` (CSS variables) and `css.gtk3` (`@define-color`, for adw-gtk3) |
| `apps.qtct theme` | A qt5ct/qt6ct color scheme for `lib.generators.toINI` |

Programs that use the terminal's 16 colors, such as bat's `base16` theme, follow
kitty's palette.

### With nix-wrapper-modules

`wrapperModules.<app>` (kitty, helix, zathura, mpv, yazi, niri) sets those
colors on the matching
[nix-wrapper-modules](https://github.com/nix-community/nix-wrapper-modules)
wrapper. Import it and pick a theme:

```nix
inputs.nix-wrapper-modules.wrappers.kitty.wrap {
  inherit pkgs;
  imports = [ inputs.base24-themes.wrapperModules.kitty ];
  base24.theme = "birdland"; # or an attrset of base00–base17
  base24.opacity = 0.95;     # kitty and zathura
}
```

The helix module adds the theme as `base24` and selects it (`settings.theme`, at
default priority, so you can pick another). It has a `transparent` option that
leaves the background to the terminal. This flake doesn't depend on
nix-wrapper-modules: the modules only set the wrappers' own options.

Without flakes, import them from `wrappers/` the way you import `lib/`:

```nix
let
  base24 = import "${base24-themes}/lib" { inherit (pkgs) lib; };
  wrappers = import "${base24-themes}/wrappers" { inherit (pkgs) lib; inherit base24; };
in
wrappers.kitty
```

## GTK and Qt apps

GTK and Qt colors are settings for every app built on them, not for one program,
so they come as a NixOS module instead of a wrapper: `nixosModules.toolkits`. It
imports `nixosModules.default`, so it uses the same `base24.theme`.

```nix
{ inputs, ... }: {
  imports = [ inputs.base24-themes.nixosModules.toolkits ];

  base24 = {
    theme = "birdland";
    gtk.enable = true;
    qt.enable = true;
  };
}
```

| Option | Default | Colors |
| ------------------- | ------- | -------------------------------------- |
| `base24.gtk.enable` | `false` | GTK 3, GTK 4 and libadwaita apps |
| `base24.qt.enable` | `false` | Qt 5 and Qt 6 apps (with Fusion style) |

They also take the other things set in the same files, all optional. Each is
`{ name; package ? null; }` (plus `size` for fonts and cursors), and a package
given is installed:

| Option | Default size | Used by |
| ------------------------------- | ------------ | -------------------------------------- |
| `base24.toolkits.iconTheme` | | GTK and Qt |
| `base24.toolkits.font` | 11 | GTK and Qt (Qt's `general` font) |
| `base24.toolkits.monospaceFont` | 11 | GTK (dconf) and Qt (Qt's `fixed` font) |
| `base24.toolkits.cursorTheme` | 24 | GTK |

What they set:

- **GTK 3 and plain GTK 4**: a theme named `base24`, which is
  [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) in the theme's variant
  with the colors added. It is selected in `/etc/xdg/gtk-3.0/settings.ini` and
  `/etc/xdg/gtk-4.0/settings.ini`, and in the system dconf database
  (`org.gnome.desktop.interface`: `gtk-theme`, and `color-scheme` from the
  theme's variant), which GTK reads instead on Wayland.
- **libadwaita**: it ignores themes, so each user's `~/.config/gtk-4.0/gtk.css`
  links to the colors as CSS variables.
- **Qt**: `qt.platformTheme = "qt5ct"`, which qt6ct also answers to, and each
  user's `qt5ct/qt5ct.conf` and `qt6ct/qt6ct.conf` link to a config that uses
  Fusion and the theme's palette.

The links in your home directory are made by systemd-tmpfiles when you log in.
They point at `/etc/xdg/base24`, so a theme change takes effect without
replacing them; restart an app to see it. A file that is already there is left
alone, so remove your own `gtk-4.0/gtk.css`, `qt5ct.conf` or `qt6ct.conf` (or
one left by Home Manager or Stylix) to let the link be made. Likewise, your own
dconf settings win over the system database; to clear old ones:

```sh
dconf reset /org/gnome/desktop/interface/gtk-theme
dconf reset /org/gnome/desktop/interface/color-scheme
```

Because the Qt configs are links to a read-only file, qt5ct and qt6ct can show
your settings but not save them.
