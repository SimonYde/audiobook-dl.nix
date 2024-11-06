{
  description = "audiobook-dl flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    audiobook-dl-src = {
      url = "github:jo1gi/audiobook-dl";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      audiobook-dl-src,
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      packages.x86_64-linux.default = self.packages.x86_64-linux.audiobook-dl;
      packages.x86_64-linux.audiobook-dl = pkgs.callPackage ./default.nix { inherit audiobook-dl-src; };
    };
}
