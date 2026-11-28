# SPDX-FileCopyrightText: 2026 Chris Palmer <chris@red-oxide.org>
# SPDX-License-Identifier: MIT

{
  description = "A structured Base16/Base24 theme flake";

  # No flake inputs: everything is pinned with tack in .tack/pins.toml
  # (`tack update` to move pins, `tack add` to add one). Using this flake
  # doesn't need tack; the resolver in .tack/default.nix reads the lock.
  #
  # A tack project that pins this one can override its pins through
  # `tackOverrides`. A flake can't `follows` them, but it doesn't need to:
  # what it exports only uses nixpkgs' lib, never packages.
  outputs =
    { self, ... }@args:
    let
      pins = (import ./.tack) { overrides = args.tackOverrides or { }; };
      # What devfmt's mkFlake (flake-parts) expects: flake-style inputs and self.
      inputs =
        removeAttrs pins [
          "__functor"
          "_meta"
          "_patched"
        ]
        // {
          inherit self;
        };
    in
    inputs.devfmt.lib.mkFlake { inherit inputs; } {
      imports = [
        (inputs.devfmt.lib.importTree ./nix)
      ];
    };
}
