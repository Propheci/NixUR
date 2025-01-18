{ pkgs,
  fenix,
  nix-filter,
}:

{
  lib = import ./lib { inherit pkgs; };
  modules = import ./modules;
  overlays = import ./overlays;

  drivedlgo = pkgs.callPackage ./pkgs/drivedlgo { inherit nix-filter; };
  watgbridge = pkgs.callPackage ./pkgs/watgbridge { inherit nix-filter; };
  pleezer = pkgs.callPackage ./pkgs/pleezer { inherit nix-filter fenix; };
}
