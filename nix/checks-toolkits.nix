# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

# nixosModules.toolkits in a real NixOS system: the options it sets, and the
# GTK theme and Qt config it writes. Built in CI; the theme is a copy of
# adw-gtk3, so it builds in seconds.
{ inputs, ... }:

{
  perSystem =
    { pkgs, system, ... }:
    let
      inherit (inputs.nixpkgs) lib;

      eval =
        base24:
        (inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # Both, to check the base module is only declared once.
            inputs.self.nixosModules.default
            inputs.self.nixosModules.toolkits
            {
              boot.isContainer = true;
              system.stateVersion = "26.05";
              inherit base24;
            }
          ];
        }).config;

      on = eval {
        theme = "harbor-light";
        gtk.enable = true;
        qt.enable = true;
      };
      off = eval { theme = "harbor-light"; };

      colors = inputs.self.lib.base24.themes.harbor-light;
      gtkTheme = lib.findFirst (
        p: (p.name or "") == "base24-gtk-theme"
      ) null on.environment.systemPackages;
      etc = name: on.environment.etc.${name}.source;
      dconf =
        (builtins.head on.programs.dconf.profiles.user.databases).settings."org/gnome/desktop/interface";
    in
    {
      checks.toolkits =
        assert gtkTheme != null;
        assert on.qt.platformTheme == "qt5ct";
        assert on.environment.variables.QT_QPA_PLATFORMTHEME == "qt5ct";
        assert dconf.gtk-theme == "base24" && dconf.color-scheme == "prefer-light";
        assert lib.elem "L %E/gtk-4.0/gtk.css - - - - /etc/xdg/base24/gtk-4.0.css"
          on.systemd.user.tmpfiles.rules;
        assert lib.elem "L %E/qt6ct/qt6ct.conf - - - - /etc/xdg/base24/qtct.conf"
          on.systemd.user.tmpfiles.rules;
        # Off by default.
        assert !(off.environment.etc ? "xdg/base24/gtk-4.0.css");
        assert off.qt.platformTheme == null;
        pkgs.runCommandLocal "base24-toolkits-check" { } ''
          t=${gtkTheme}/share/themes/base24
          grep -qx 'Name=base24' $t/index.theme
          grep -q '^@define-color accent_bg_color #${colors.base0D};' $t/gtk-3.0/gtk.css
          grep -q -- '--accent-bg-color: #${colors.base0D};' $t/gtk-4.0/gtk.css
          grep -q -- '--window-bg-color: #${colors.base00};' ${etc "xdg/base24/gtk-4.0.css"}
          grep -qx 'gtk-theme-name=base24' ${etc "xdg/gtk-3.0/settings.ini"}
          grep -qx 'color_scheme_path=/etc/xdg/base24/qtct-colors.conf' ${etc "xdg/base24/qtct.conf"}
          grep -q '^active_colors=#ff' ${etc "xdg/base24/qtct-colors.conf"}
          touch $out
        '';
    };
}
