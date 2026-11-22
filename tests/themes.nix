# Bundled themes (themes/), their previews and cards (previews/) and the
# gallery (docs/gallery.md).
{ base24, fixtures, ... }:

let
  inherit (base24) themes luminance contrastRatio;
  inherit (fixtures) fails;
  all = predicate: builtins.all predicate (builtins.attrValues themes);

  accents = [
    "base08"
    "base09"
    "base0A"
    "base0B"
    "base0C"
    "base0D"
    "base0E"
    "base0F"
  ];
  accentsReach =
    ratio: background: theme:
    builtins.all (name: contrastRatio (base24.getColor theme name) background >= ratio) accents;
in
{
  birdlandDiscovered = themes ? birdland;

  haveNames = all (theme: builtins.isString (theme.name or null));

  valid = all (theme: !(fails (base24.getColors theme)));

  # Bundled themes must define every color (no fallbacks) ...
  complete = all (theme: builtins.all (name: theme ? ${name}) base24.colorNames);

  # ... and keep the Base24 depth order: base11 <= base10 <= base00.
  depthOrder = all (
    theme:
    let
      c = base24.getColors theme;
    in
    luminance c.base11 <= luminance c.base10 && luminance c.base10 <= luminance c.base00
  );

  # Every accent (base08 to base0F) reaches WCAG AA, 4.5:1, on the background:
  # the claim each bundled theme's page makes.
  accentContrast = all (theme: accentsReach 4.5 (base24.getColors theme).base00 theme);

  # Birdland Light also promises it on the panel background.
  birdlandLightPanelContrast = accentsReach 4.5 themes.birdland-light.base01 themes.birdland-light;

  # previews/<theme>.svg must match `nix eval --raw .#lib.base24.previews.<theme>`.
  previewsUpToDate = builtins.all (
    name:
    let
      file = ../previews + "/${name}.svg";
    in
    builtins.pathExists file && builtins.readFile file == base24.previews.${name}
  ) (builtins.attrNames themes);

  # previews/cards/<theme>.svg must match `nix eval --raw .#lib.base24.cards.<theme>`.
  cardsUpToDate = builtins.all (
    name:
    let
      file = ../previews/cards + "/${name}.svg";
    in
    builtins.pathExists file && builtins.readFile file == base24.cards.${name}
  ) (builtins.attrNames themes);

  # Every bundled theme has a page, which the gallery links to.
  pagesExist = builtins.all (name: builtins.pathExists (../docs + "/${name}.md")) (
    builtins.attrNames themes
  );

  # docs/gallery.md must match `nix eval --raw .#lib.base24.gallery`.
  galleryUpToDate = builtins.readFile ../docs/gallery.md == base24.gallery;
}
