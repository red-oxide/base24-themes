# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# A NixOS module coloring every GTK and Qt app with the selected theme
# (`base24.theme`, from nixosModules.base24, which it imports):
#
#   base24.gtk.enable  GTK 3 and plain GTK 4 apps get an adw-gtk3 theme named
#                      `base24` with the colors added, selected in
#                      /etc/xdg/gtk-{3,4}.0/settings.ini and in dconf (which
#                      GTK reads on Wayland), along with the color scheme.
#                      libadwaita apps ignore themes, so each user's
#                      gtk-4.0/gtk.css links to the colors.
#   base24.qt.enable   Qt 5 and 6 apps use qt5ct/qt6ct with the Fusion style
#                      and the theme's palette; each user's qt5ct.conf and
#                      qt6ct.conf link to it.
#   base24.toolkits.*  Optional icon theme, fonts and cursor theme, written to
#                      the same settings files (and installed).
#
# Users' files are links made at login by systemd-tmpfiles. They point at
# /etc/xdg/base24, so they don't change when the theme does, and a file the
# user already has is left alone.
{ config, ... }:

let
  base24 = config.flake.lib.base24;
  base = config.flake.nixosModules.base24;

  module =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.base24;
      theme = config.lib.base24.selected;
      dark = (base24.getMeta theme).variant == "dark";
      gtk = base24.apps.gtk theme;
      etc = "/etc/xdg/base24";

      # adw-gtk3, in the theme's variant, with the colors appended to each
      # stylesheet so they win over adw-gtk3's own.
      gtkTheme =
        pkgs.runCommand "base24-gtk-theme"
          {
            gtk3 = gtk.css.gtk3;
            gtk4 = gtk.css.gtk4;
            passAsFile = [
              "gtk3"
              "gtk4"
            ];
          }
          ''
            dir=$out/share/themes/base24
            mkdir -p $out/share/themes
            cp -rL --no-preserve=mode ${pkgs.adw-gtk3}/share/themes/adw-gtk3${lib.optionalString dark "-dark"} $dir
            sed -i 's/^Name=.*/Name=base24/' $dir/index.theme
            for css in $dir/gtk-3.0/gtk*.css; do cat $gtk3Path >> $css; done
            for css in $dir/gtk-4.0/gtk*.css; do cat $gtk4Path >> $css; done
          '';

      inherit (cfg.toolkits)
        iconTheme
        font
        monospaceFont
        cursorTheme
        ;
      set = value: lib.optionalAttrs (value != null);
      gtkFont = f: "${f.name} ${toString f.size}";
      # Quoted: unquoted, QSettings would read the comma as a list.
      qtFont = f: ''"${f.name},${toString f.size}"'';

      settingsIni = lib.generators.toINI { } {
        Settings = {
          gtk-theme-name = "base24";
        }
        // set iconTheme { gtk-icon-theme-name = iconTheme.name; }
        // set font { gtk-font-name = gtkFont font; }
        // set cursorTheme {
          gtk-cursor-theme-name = cursorTheme.name;
          gtk-cursor-theme-size = cursorTheme.size;
        };
      };

      qtConf = lib.generators.toINI { } (
        {
          Appearance = {
            color_scheme_path = "${etc}/qtct-colors.conf";
            custom_palette = true;
            style = "Fusion";
          }
          // set iconTheme { icon_theme = iconTheme.name; };
        }
        // lib.optionalAttrs (font != null || monospaceFont != null) {
          Fonts = set font { general = qtFont font; } // set monospaceFont { fixed = qtFont monospaceFont; };
        }
      );

      # A name, a size and the package providing it, for fonts and cursors.
      named =
        what: defaultSize:
        lib.types.nullOr (
          lib.types.submodule {
            options = {
              name = lib.mkOption {
                type = lib.types.str;
                description = "The ${what}'s name.";
              };
              package = lib.mkOption {
                type = lib.types.nullOr lib.types.package;
                default = null;
                description = "The package providing the ${what}, installed when set.";
              };
            }
            // lib.optionalAttrs (defaultSize != null) {
              size = lib.mkOption {
                type = lib.types.ints.positive;
                default = defaultSize;
                description = "The ${what}'s size.";
              };
            };
          }
        );
      packages = lib.concatMap (x: lib.optional (x != null && x.package != null) x.package);

      link = path: target: "L %E/${path} - - - - ${target}";
    in
    {
      imports = [ base ];

      options.base24 = {
        gtk.enable = lib.mkEnableOption "the selected theme for GTK 3, GTK 4 and libadwaita apps";
        qt.enable = lib.mkEnableOption "the selected theme for Qt 5 and Qt 6 apps";

        # Not colors, but set in the same files, so set here too.
        toolkits = {
          iconTheme = lib.mkOption {
            type = named "icon theme" null;
            default = null;
            example = lib.literalExpression ''{ name = "Yaru-sage"; package = pkgs.yaru-theme; }'';
            description = "Icon theme for GTK and Qt apps.";
          };
          font = lib.mkOption {
            type = named "font" 11;
            default = null;
            example = lib.literalExpression ''{ name = "Inter"; size = 11; package = pkgs.inter; }'';
            description = "Interface font for GTK and Qt apps.";
          };
          monospaceFont = lib.mkOption {
            type = named "font" 11;
            default = null;
            description = "Monospace font for GTK (dconf) and Qt apps.";
          };
          cursorTheme = lib.mkOption {
            type = named "cursor theme" 24;
            default = null;
            example = lib.literalExpression ''{ name = "Bibata-Modern-Amber"; size = 24; package = pkgs.bibata-cursors; }'';
            description = "Cursor theme for GTK apps.";
          };
        };
      };

      config = lib.mkIf cfg.enable (
        lib.mkMerge [
          (lib.mkIf cfg.gtk.enable {
            environment.systemPackages = [
              gtkTheme
            ]
            ++ packages [
              iconTheme
              cursorTheme
            ];
            fonts.packages = packages [
              font
              monospaceFont
            ];
            environment.etc = {
              "xdg/gtk-3.0/settings.ini".text = settingsIni;
              "xdg/gtk-4.0/settings.ini".text = settingsIni;
              "xdg/base24/gtk-4.0.css".text = gtk.css.gtk4;
            };
            # The system database: each user's own dconf settings still win.
            programs.dconf.profiles.user.databases = [
              {
                settings."org/gnome/desktop/interface" = {
                  gtk-theme = "base24";
                  color-scheme = if dark then "prefer-dark" else "prefer-light";
                }
                // set iconTheme { icon-theme = iconTheme.name; }
                // set font { font-name = gtkFont font; }
                // set monospaceFont { monospace-font-name = gtkFont monospaceFont; }
                // set cursorTheme {
                  cursor-theme = cursorTheme.name;
                  cursor-size = lib.gvariant.mkInt32 cursorTheme.size;
                };
              }
            ];
            systemd.user.tmpfiles.rules = [ (link "gtk-4.0/gtk.css" "${etc}/gtk-4.0.css") ];
          })

          (lib.mkIf cfg.qt.enable {
            environment.systemPackages = packages [ iconTheme ];
            fonts.packages = packages [
              font
              monospaceFont
            ];
            qt = {
              enable = true;
              # qt6ct answers to qt5ct too, so this covers Qt 5 and Qt 6.
              platformTheme = lib.mkDefault "qt5ct";
            };
            environment.etc = {
              "xdg/base24/qtct-colors.conf".text = lib.generators.toINI { } (base24.apps.qtct theme);
              "xdg/base24/qtct.conf".text = qtConf;
            };
            systemd.user.tmpfiles.rules = [
              (link "qt5ct/qt5ct.conf" "${etc}/qtct.conf")
              (link "qt6ct/qt6ct.conf" "${etc}/qtct.conf")
            ];
          })
        ]
      );
    };
in
{
  flake.nixosModules.toolkits = {
    key = "base24-themes#toolkits";
    imports = [ module ];
  };
}
